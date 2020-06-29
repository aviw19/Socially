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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.6,
              margin: EdgeInsets.all(5),
              child: Elevation95(
                type: Elevation95Type.down,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          width: 100,
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.all(10),
                          child: Elevation95(
                              type: Elevation95Type.down,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                    height: 100,
                                    width: 100,
                                    child:
                                        Image.asset('assets/profile.png')),
                              ))),
                      SizedBox(height: 30),
                      Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            'NAME',
                            style: TextStyle(fontSize: 18),
                          )),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        margin: EdgeInsets.only(left: 10),
                        child: Elevation95(
                            type: Elevation95Type.down,
                            child: Container(
                                margin: EdgeInsets.all(5),
                                child: Text(
                                  "AVI WADHWA",
                                  style: TextStyle(fontSize: 18),
                                ))),
                      ),
                      SizedBox(height: 20),
                      Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            'USERNAME',
                            style: TextStyle(fontSize: 18),
                          )),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        margin: EdgeInsets.only(left: 10),
                        child: Elevation95(
                            type: Elevation95Type.down,
                            child: Container(
                                margin: EdgeInsets.all(5),
                                child: Text(
                                  "AVIW19",
                                  style: TextStyle(fontSize: 18),
                                ))),
                      ),
                      SizedBox(height: 20),
                      Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            'DISPLAY NAME',
                            style: TextStyle(fontSize: 18),
                          )),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        margin: EdgeInsets.only(left: 10),
                        child: Elevation95(
                            type: Elevation95Type.down,
                            child: Container(
                                margin: EdgeInsets.all(5),
                                child: Text(
                                  "AVIW19",
                                  style: TextStyle(fontSize: 18),
                                ))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            'EMAIL',
                            style: TextStyle(fontSize: 18),
                          )),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        margin: EdgeInsets.only(left: 10),
                        child: Elevation95(
                            type: Elevation95Type.down,
                            child: Container(
                                margin: EdgeInsets.all(5),
                                child: Text(
                                  "EXAMPLE@EXAMPLE.com",
                                  style: TextStyle(fontSize: 18),
                                ))),
                      ),
                      SizedBox(height: 20),
                    ]),
              ),
            ),
            Row(children: <Widget>[
            Container(
                margin: EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width * 0.64,
                height: MediaQuery.of(context).size.width * 0.47,
                child: Elevation95(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
                          height: MediaQuery.of(context).size.height * 0.07,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: Button95(
                            child: Center(
                                child: Text('EDIT PROFILE',
                                    style: TextStyle(
                                        fontFamily: 'Orangekid',
                                        fontSize: 24))),
                            onTap: () {},
                          )),
                      Container(
                          margin: EdgeInsets.fromLTRB(10, 20, 20, 0),
                          height: MediaQuery.of(context).size.height * 0.07,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: Button95(
                            child: Center(
                                child: Text('CHANGE PASSWORD',
                                    style: TextStyle(
                                        fontFamily: 'Orangekid',
                                        fontSize: 24))),
                            onTap: () {},
                          )),
                    ],
                  ),
                )),
            Container(
              width: MediaQuery.of(context).size.width*0.31,
              height: MediaQuery.of(context).size.width * 0.47,
              margin: EdgeInsets.fromLTRB(0, 5, 5, 5),
              child: Elevation95(
                type: Elevation95Type.down,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                  Text('No. OF POSTS',style: TextStyle(fontSize: 20),),
                  SizedBox(height:20),
                  Text('20,200',style: TextStyle(fontSize: 20)),
                ],),
              ),
              
            )]),
            Container(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(5, 5, 5,0),
                    width: MediaQuery.of(context).size.width,
                    child: Elevation95(
                      child: Align(

                        alignment: Alignment.topLeft,
                        child:Container(
                            width: MediaQuery.of(context).size.width *0.14,
                            child:Elevation95(
                                child: GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      height: MediaQuery.of(context).size.height*0.04,

                                      child: Image.asset('assets/flutterLogo.png'),
                                    )))),
                      ),
                    ),
                  ),
                )),


          ],
        ),
      ),
    );
  }
}
