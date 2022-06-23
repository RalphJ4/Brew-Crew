import 'package:flutter/material.dart';
import 'package:practice/services/auth.dart';
import 'package:practice/shared/constants.dart';
import 'package:practice/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  const SignIn({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? const Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text("Sign in to Ralph's Brew Crew"),
        actions: <Widget>[
          TextButton.icon(
              icon: const Icon(Icons.person),
              onPressed: () {
                widget.toggleView();
              },
              label: const Text('Register')),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(children: <Widget>[

            Text('Login', style: TextStyle(fontSize: 40,
            color: Colors.brown[700]),),
            const SizedBox(height: 20),
            TextFormField(
              decoration: textInputDecoration.copyWith(hintText: 'Email'),
              validator: (val) => val!.isEmpty ? 'Enter an Email' : null,
              onChanged: (val) {
                setState(() => email = val);
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: textInputDecoration.copyWith(hintText: 'Password'),
              validator: (val) => val!.length < 6 ? 'Enter a password 6+ char long' : null,
              obscureText: true,
              onChanged: (val) {
                setState(() => password = val);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              
              style: ElevatedButton.styleFrom(
                primary: Colors.pink,
              ),
              child: const Text(
                'Sign in',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                 if(_formKey.currentState!.validate()){
                  setState(() => loading = true);
                  dynamic result = await _auth.signInWithEmailAndPassword(email, password);

                  if(result == null){
                    setState(() {

                     error = 'could not sign in with that credential';
                     loading = false;
                     });
                   
                  }
                }
              },
            ),
            const SizedBox(height: 20) ,
            Text(
              error,
              style: const TextStyle(color: Colors.red, fontSize: 14),
            ),
          ]),
        ),
      ),
    );
  }
}
