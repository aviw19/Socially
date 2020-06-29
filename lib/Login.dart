import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter95/flutter95.dart';
import 'package:socially/Home.dart';
import 'package:socially/SignUp.dart';
import 'package:socially/masterDetails.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

final em = TextEditingController();
final pwd = TextEditingController();
String _email;
String _password;
String authError=null;
bool errorTextPresentEmail = false;
bool errorTextPresentPassword = false;
String errorTextEmail;
String errorTextPassword;

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,

          body: Scaffold95(
              canPop: false,
              title: "WELCOME",
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Center(
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: Image.asset('assets/logo2.png'))),
                  Center(
                      child: Text(
                    'SOCIALLY',
                    style: TextStyle(fontSize: 56),
                  )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(40, 0, 40, 10),
                      child: Text("USERNAME",
                          style: TextStyle(
                              fontFamily: 'Orangekid', fontSize: 24))),
                  Container(
                      margin: EdgeInsets.fromLTRB(40, 0, 40, 20),
                      child: TextField95(
                        obscuretext: false,
                        controller: em,
                      )),
                  Container(
                      margin: EdgeInsets.fromLTRB(40, 0, 40, 00),
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.width * 0.12,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: Button95(
                          child: Center(
                              child: Text('LOGIN',
                                  style: TextStyle(
                                      fontFamily: 'Orangekid', fontSize: 30))),
                          onTap: () async {
                            FirebaseAuth auth = FirebaseAuth.instance;
                            _email = em.text.trim();
                            _password = pwd.text.trim();

                            FirebaseUser fbuser;
                            AuthResult result;
                            try
                            {
                              result = await auth.signInWithEmailAndPassword(
                                  email: _email, password: _password);
                            }
                            on PlatformException catch (e) {
                              switch (e.code) {
                                case 'ERROR_USER_NOT_FOUND':
                                  authError =
                                  "User does not exist, Create one?";
                                  errorTextPresentEmail = true;
                                  break;
                                case 'ERROR_INVALID_EMAIL':
                                  authError = 'Invalid Email';
                                  errorTextPresentEmail = true;
                                  break;
                                case 'ERROR_WRONG_PASSWORD':
                                  authError = 'Incorrect Password';
                                  errorTextPresentPassword = true;
                                  break;
                                default:
                                  authError = e.code.toString();
                              }
                            }
                            print(authError);
                            if(authError==null)
                            {
                              fbuser=result.user;
                              masterDetails.firebaseid=fbuser.uid;
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  //name MemeaTOken
                                  MaterialPageRoute(builder: (context) =>
                                      Home()),
                                  ModalRoute.withName('/Login')
                              );
                            }
                          })),
                  Container(
                      margin: EdgeInsets.fromLTRB(40, 10, 40, 0),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.width * 0.12,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: Button95(
                          child: Center(
                              child: Text('SIGNUP',
                                  style: TextStyle(
                                      fontFamily: 'Orangekid', fontSize: 30))),
                          onTap: ()  {
                            Navigator.push(
                                context,
                                //name MemeaTOken
                                MaterialPageRoute(builder: (context) =>
                                    SignUp()),
                            );
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
                        )),
                  ),
                ],
              )),
        );
  }
}
