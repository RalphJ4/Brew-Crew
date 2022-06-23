import 'package:firebase_auth/firebase_auth.dart';
import 'package:practice/models/user.dart';
import 'package:practice/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create MyUser object based on User
  CustomUserName? _userfromFirebase(User? user) {
    return user != null ? CustomUserName(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<CustomUserName?> get user {
    return _auth.authStateChanges()
    //.map((User? user) => _userfromFirebase(user!));
    .map(_userfromFirebase);
  }


  // sign in anoonymous
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userfromFirebase(user!);
    } catch (e) {
      (e.toString());
      return null;
    }
  }
  // sign in withhh email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try{
        UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
        User? user = result.user;
        return _userfromFirebase(user);
    }catch(e){
      (e.toString());
      return null;
    }
  }


  // register withhhhh email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try{
        UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        User? user = result.user;

          //create a new document for the user with the uid 
        await DatabaseService(uid: user!.uid).updateUserData('0', 'new crew member', 100);
        return _userfromFirebase(user);
    }catch(e){
      (e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch (e){
      (e.toString());
      return null;
    }
  }
}
