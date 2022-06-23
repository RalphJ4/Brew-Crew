import 'package:flutter/material.dart';
import 'package:practice/models/brew.dart';
import 'package:practice/screens/home/brew_list.dart';
import 'package:practice/screens/home/settings_form.dart';
import 'package:practice/services/auth.dart';
import 'package:practice/services/database.dart';
import 'package:provider/provider.dart';


class Home extends StatelessWidget {
   Home({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(
        context: context, 
        builder: (context){
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
          child: const SettingsForm(),
          );
        }
      );
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      initialData: const [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: const Text("Ralph's Brew Crew"),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: const Icon(Icons.person),
              label: const Text('Logout'),
            ),
            TextButton.icon(
              icon: const Icon(Icons.settings),
              label: const Text('Settings'),
              onPressed: () => _showSettingsPanel(),
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            )
          ),
          child: const BrewList(),
        ),
      ),
    );
  }
}
