import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter95/flutter95.dart';
import 'package:socially/chatScreen.dart';

class ChatRoomList extends StatefulWidget {
  @override
  _ChatRoomListState createState() => _ChatRoomListState();
}

class _ChatRoomListState extends State<ChatRoomList> {
  Firestore firestore = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold95(
        title: "List of Chatrooms",
        body: Container(
          child: StreamBuilder(
              stream: firestore.collection("chats").document().snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(),
                  );

                List<DocumentSnapshot> docs = snapshot.data.documents;
                List<Widget> channels = docs
                    .map((doc) => Container(
                          color: Colors.white,
                          child: ListTile(
                            trailing: Button95(
                              child: Text("JOIN"),
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatScreen(
                                              channel: doc["title"],
                                            )),
                                    (Route<dynamic> route) => false);
                              },
                            ),
                            title: Text(doc["title"]),
                          ),
                        ))
                    .toList();

                return ListView(
                  shrinkWrap: true,
                  children: <Widget>[...channels],
                );
              }),
        ),
        canPop: true);
  }
}
