import 'package:flutter/material.dart';
import 'package:flutter95/flutter95.dart';
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold95(
        title: "PROFILE",
        canPop: true,

        body:Column(children: <Widget>[
          Elevation95(
            child: Column(),
          ),


        ],) ,


      ),
    );
  }
}
