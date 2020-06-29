import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter95/flutter95.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socially/chatScreen.dart';

class CreateChatRoom extends StatefulWidget {
  @override
  _CreateChatRoomState createState() => _CreateChatRoomState();
}

class _CreateChatRoomState extends State<CreateChatRoom> {
  TextEditingController nameController, purposeController;
  Firestore firestore;
  @override
  void initState() {
    nameController = new TextEditingController();
    purposeController = new TextEditingController();
    firestore = Firestore.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold95(
          title: "Create New Room",
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Elevation95(
                  child: Container(
                    child: Text(
                      "Create Chatroom",
                      style: TextStyle(fontSize: 30),
                    ),
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
                    child: Text("CHATROOM NAME",
                        style:
                            TextStyle(fontFamily: 'Orangekid', fontSize: 24))),
                Container(
                    margin: EdgeInsets.fromLTRB(40, 0, 40, 20),
                    child: TextField95(
                      controller: nameController,
                       obscuretext: false,
                      //  controller: name,
                    )),
                Container(
                    margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
                    child: Text("PURPOSE",
                        style:
                            TextStyle(fontFamily: 'Orangekid', fontSize: 24))),
                Container(
                    margin: EdgeInsets.fromLTRB(40, 0, 40, 20),
                    child: TextField95(
                      controller: purposeController,
                         obscuretext: false,
                      //  controller: uname,
                    )),
                SizedBox(
                  height: 140,
                ),
                Center(
                  child: Button95(
                    onTap: () {
                      createChatroom();
                    },
                    height: 40,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Center(
                        child: Text(
                          "Create",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          canPop: true),
    );
  }

  Future createChatroom() async {
    if (nameController.text.length > 0 && purposeController.text.length > 0) {
      await firestore.collection("chats").document(nameController.text).setData(
          {"name": nameController.text, "purpose": purposeController.text});
      //Fluttertoast.showToast(msg: "ChatRoom Created");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => ChatScreen(
                    channel: nameController.text,
                  )),
          (route) => false);
    }
  }
}
