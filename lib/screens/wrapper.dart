import 'package:flutter/material.dart';
import 'package:practice/models/user.dart';
import 'package:practice/screens/authenticate/authenticate.dart';
import 'package:practice/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        
    final userprovider = Provider.of<CustomUserName?>(context);
    // print(userprovider);
      
    //return either Home or Autheticate Widget
    if (userprovider == null){
      return const Authenticate();
    }else{
      return Home();
    }
  }
}