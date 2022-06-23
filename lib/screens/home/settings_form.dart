import 'package:flutter/material.dart';
import 'package:practice/models/user.dart';
import 'package:practice/services/database.dart';
import 'package:practice/shared/constants.dart';
import 'package:practice/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = [
    '0',
    '1',
    '2',
    '3',
    '4',
  ];

  //form values
  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {

    final userprovider = Provider.of<CustomUserName?>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: userprovider?.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){

          UserData? userData = snapshot.data;

            return Form(
          key: _formKey,
          child: Column(children: <Widget>[
            const Text(
              'Update your brew settings.',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: userData?.name,
              decoration: textInputDecoration,
              validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
              onChanged: (val) => setState(() => _currentName = val),
            ),
            const SizedBox(height: 20),
            //dropdown
            DropdownButtonFormField<String>(
              decoration: textInputDecoration,
              value: _currentSugars ?? userData?.sugars,
              items: sugars.map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text('$e sugars'),
                );
              }).toList(),
              onChanged: (val) => setState(
                () => _currentSugars = val,
              ),
            ),
            //slider
            Slider(
              value: (_currentStrength ?? userData?.strength)!.toDouble(),
              activeColor: Colors.brown[_currentStrength ?? userData!.strength],
              inactiveColor: Colors.brown[_currentStrength ?? userData!.strength],
              min: 100,
              max: 900,
              divisions: 8,
              onChanged: (val) => setState(() => _currentStrength = val.round()),
            ),
    
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.pink,
              ),
              child: const Text(
                'Update',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                if(_formKey.currentState!.validate()){
                  await DatabaseService(uid: userprovider!.uid).updateUserData(
                    _currentSugars ?? userData!.sugars,
                    _currentName ?? userData!.name,
                    _currentStrength ?? userData!.strength,
                    
                  );
                  Navigator.pop(context);
                }
              },
            ),
          ]),
        );
        } else {
            return const Loading();
        }
        
      }
    );
  }
}
