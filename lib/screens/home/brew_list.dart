import 'package:flutter/material.dart';
import 'package:practice/models/brew.dart';
import 'package:practice/screens/home/brew_tile.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  const BrewList({Key? key}) : super(key: key);

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context);
    // print(brews?.docs);
    // if (brews != null) {
    //   for (var doc in brews.docs) {
    //     print(doc.data());
    //   }

    // brews.forEach((brew) {
    //   print(brew.name);
    //   print(brew.sugars);
    //   print(brew.strength);
    // });
    

    return ListView.builder(
      itemCount: brews.length, 
      itemBuilder: (context,  index) {  
        return BrewTile(brew: brews[index]);
      },
    );
  }
}
