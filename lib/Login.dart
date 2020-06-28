import 'package:flutter/material.dart';
import 'package:flutter95/flutter95.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

final email = TextEditingController();
final password = TextEditingController();

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scaffold95(
        title: "WELCOME",
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          Container(
              margin: EdgeInsets.fromLTRB(40, 0, 40, 10),
              child: Text("USERNAME",
                  style: TextStyle(fontFamily: 'Orangekid', fontSize: 24))),
          Container(
              margin: EdgeInsets.fromLTRB(40, 0, 40, 20),
              child: TextField95(
                controller: email,
              )),
          Container(
              margin: EdgeInsets.fromLTRB(40, 0, 40, 10),
              child:GestureDetector(
                onTap: (){},
              child: Text(
                "PASSWORD",
                style: Flutter95.textStyle,
              ))),
          Container(
              margin: EdgeInsets.fromLTRB(40, 0, 40, 20),
              child: TextField95(
                controller: email,
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Container(
              margin: EdgeInsets.fromLTRB(40, 0, 40, 10),
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.width * 0.12,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Button95(
                child: Center(
                    child: Text('LOGIN',
                        style:
                            TextStyle(fontFamily: 'Orangekid', fontSize: 30))),
                onTap: () {},
              )),
          Container(
              margin: EdgeInsets.fromLTRB(40, 10, 40, 0),
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.width * 0.12,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Button95(
                child: Center(
                    child: Text('SIGNUP',
                        style:
                            TextStyle(fontFamily: 'Orangekid', fontSize: 30))),
                onTap: () {},
              )),
            Item95()
        ],
      ),
    ));
  }
}
