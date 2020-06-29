import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter95/flutter95.dart';
import 'package:socially/Home.dart';
import 'package:socially/masterDetails.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

final em = TextEditingController();
final pwd = TextEditingController();
final uname=TextEditingController();
final dob=TextEditingController();
final name = TextEditingController();
var databaseReference;
String _email="";
String _password="";
String _username="";
String _name="";
String _dateofbirth="";
String authError="lol";

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Scaffold95(
        canPop: false,
        title: 'SIGNUP',
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Container(
                margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: Text("NAME",
                    style: TextStyle(fontFamily: 'Orangekid', fontSize: 24))),
            Container(
                margin: EdgeInsets.fromLTRB(40, 0, 40, 20),
                child: TextField95(
                  obscuretext: false,
                  controller: name,
                )),
            Container(
                margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: Text("USERNAME",
                    style: TextStyle(fontFamily: 'Orangekid', fontSize: 24))),
            Container(
                margin: EdgeInsets.fromLTRB(40, 0, 40, 20),
                child: TextField95(
                  obscuretext: false,
                  controller: uname,
                )),
            Container(
                margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: Text("DATE OF BIRTH",
                    style: TextStyle(fontFamily: 'Orangekid', fontSize: 24))),
            Container(
                margin: EdgeInsets.fromLTRB(40, 0, 40, 20),
                child: TextField95(
                  obscuretext: false,
                  controller: dob,
                )),
            Container(
                margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: Text("EMAIL",
                    style: TextStyle(fontFamily: 'Orangekid', fontSize: 24))),
            Container(
                margin: EdgeInsets.fromLTRB(40, 0, 40, 20),
                child: TextField95(
                  obscuretext: false,
                  controller: em,
                )),
            Container(
                margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: Text(
                  "PASSWORD",
                  style: Flutter95.textStyle,
                )),
            Container(
                margin: EdgeInsets.fromLTRB(40, 0, 40, 20),
                child: TextField95(
                  obscuretext: true,
                  controller: pwd,
                )),
            Container(
                margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: Text(
                  "CONFIRM PASSWORD",
                  style: Flutter95.textStyle,
                )),
            Container(
                margin: EdgeInsets.fromLTRB(40, 0, 40, 20),
                child: TextField95(
                  obscuretext: true,
                  //controller: pwd,
                )),
            SizedBox(
              height: 40,
            ),
            Container(
                margin: EdgeInsets.fromLTRB(40, 10, 40, 0),
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.width * 0.12,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Button95(
                    child: Center(
                        child: Text('SIGNUP',
                            style: TextStyle(
                                fontFamily: 'Orangekid', fontSize: 30))),
                    onTap: () async {
                      FirebaseAuth auth = FirebaseAuth.instance;
                      AuthResult result;
                      _email=em.text.trim();
                      _password=pwd.text.trim();

                      try {
                        result = await auth.createUserWithEmailAndPassword(
                            email: _email, password: _password);

                      }
                      on PlatformException catch (e) {
                        print(e.code);
                        switch (e.code) {
                          case 'ERROR_EMAIL_ALREADY_IN_USE':
                            authError =
                            "An account already exists with this email";
                            break;
                          case 'ERROR_INVALID_EMAIL':
                            authError = "Please enter a valid email";
                            break;
                          case 'ERROR_WEAK_PASSWORD':
                            authError = "Please set a strong password";
                            break;
                          default:
                            authError = e.code;
                        }}
                        if(authError=="lol")
                          {
                          FirebaseUser fbuser=result.user;
                      databaseReference= Firestore.instance;
                      _username=uname.text.trim();
                      _name=name.text.trim();
                      _dateofbirth=dob.text.trim();
                      _email=em.text.trim();
                      masterDetails.firebaseid=fbuser.uid;
                      await databaseReference.collection("users")
                          .document(fbuser.uid)
                          .setData({
                        'name': _name,
                        'username':_username,
                        'dateofbirthe':_dateofbirth,
                        'email': _email,
                      });

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                          );}

                    })),
            SizedBox(
              height: 40,
            ),
            Center(
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Divider(
                      color: Color(0xff0E0E0E),
                      thickness: 4,
                    ))),
          ],
        ),
      ),
    );
  }

  Future<void> createRecord(String uid) async {

  }
}
