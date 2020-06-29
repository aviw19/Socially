import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter95/flutter95.dart';
import 'package:socially/chatRoomList.dart';

class ChatScreen extends StatefulWidget {
  String channel = "general";
  ChatScreen({this.channel});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController;
  ScrollController scrollController;
  String channel;
  final Firestore _firestore = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> callback() async {
    if (messageController.text.length > 0) {
      await _firestore
          .collection("chats")
          .document(channel)
          .collection("messages")
          .add({
        'text': messageController.text,
        'from': (await _auth.currentUser()).displayName,
      });
      messageController.clear();
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  @override
  void initState() {
    channel = widget.channel;
    messageController = new TextEditingController();
    scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Scaffold95(
          canPop: true,
          title: "CHATROOM",
          body: Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(10),
              color: Color(0xffC0C0C0),
              child: Column(
                children: <Widget>[
                  Elevation95(
                    type: Elevation95Type.down,
                    child: Container(
                      margin: EdgeInsets.all(5),
                      child: Row(
                        children: <Widget>[
                          Elevation95(
                            type: Elevation95Type.down,
                            child: Button95(
                              onTap: null,
                              child: Text(
                                "Create Chatroom",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Elevation95(
                            type: Elevation95Type.down,
                            child: Button95(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ChatRoomList()));
                              },
                              child: Text(
                                "View Available Chatrooms",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.65,
                    color: Colors.white,
                    child: StreamBuilder(
                      stream: _firestore
                          .collection("chats")
                          .document(channel)
                          .collection("messages")
                          .document()
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData)
                          return Center(
                            child: CircularProgressIndicator(),
                          );

                        List<DocumentSnapshot> docs = snapshot.data.documents;
                        List<Widget> messages = docs
                            .map((doc) => ChatItem(
                                  message: doc.data['text'],
                                  name: doc.data['from'],
                                ))
                            .toList();
                        return ListView(
                          controller: scrollController,
                          children: <Widget>[...messages],
                          shrinkWrap: true,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(5),
                          width: MediaQuery.of(context).size.width * 0.69,
                          height: 100,
                          child: Material(
                              child: TextField(
                            style: TextStyle(fontSize: 20),
                            maxLines: 20,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                            ),
                          )),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Button95(
                                onTap: () async {
                                  await callback();
                                },
                                height: 40,
                                child: Center(
                                  child: Text(
                                    "SEND",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: Elevation95(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.14,
                            child: Elevation95(
                                child: GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      child:
                                          Image.asset('assets/flutterLogo.png'),
                                    )))),
                      ),
                    ),
                  ),
                ],
              ))),
    );
  }
}

class ChatItem extends StatefulWidget {
  String name;
  String message;
  ChatItem({@required this.message, @required this.name});
  @override
  _ChatItemState createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  @override
  Widget build(BuildContext context) {
    return Elevation95(
      type: Elevation95Type.up,
      child: ListTile(
        leading: Icon(
          Icons.person_outline,
          color: Colors.black,
          size: 25,
        ),
        title: Text(
          "Name",
          style: TextStyle(fontSize: 24),
        ),
        subtitle: Text(
          "Hello everyone",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
