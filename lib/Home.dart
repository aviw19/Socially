import 'package:flutter/material.dart';
import 'package:flutter95/flutter95.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF01817F),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: MediaQuery.of(context).size.width*0.15,
                  margin: EdgeInsets.only(left: 20),
                  child: Image.asset('assets/chatroom.png'),
                )),
            Align(
                alignment: Alignment.topLeft,
                child: Container(

                  margin: EdgeInsets.only(left: 20),
                  child: Text('CHATROOM',style: TextStyle(fontSize: 20),),
                )),
            SizedBox(
              height: 40,
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.only(left: 20),
                  width: MediaQuery.of(context).size.width*0.15,
                  child: Image.asset('assets/videocall.png'),
                )),
            Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Text('VIDEOCHAT',style: TextStyle(fontSize: 20),),
                )),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: Elevation95(
                    child: Align(

                        alignment: Alignment.topLeft,
                      child:Container(
                        width: MediaQuery.of(context).size.width *0.14,
                        child:Elevation95(
                        child: GestureDetector(
                            onTap: () {},
                            child: Container(

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

  Menu95 _buildMenu() {
    return Menu95(
      items: [
        MenuItem95(
          value: 1,
          label: 'New',
        ),
        MenuItem95(
          value: 2,
          label: 'Open',
        ),
        MenuItem95(
          value: 3,
          label: 'Exit',
        ),
      ],
      onItemSelected: (item) {},
    );
  }
}