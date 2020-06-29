import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter95/flutter95.dart';
import 'package:socially/SignUp.dart';
import 'package:socially/chatRoomList.dart';
import 'package:socially/createChatRoom.dart';
import 'package:translator/translator.dart';

class ChatScreen extends StatefulWidget {
  String channel;

  ChatScreen({this.channel});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController;
  ScrollController scrollController;
  String channel = "general";
  final Firestore _firestore = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> translate(String input) async{
    final translator = GoogleTranslator();
    translator.translate(input,to:'pt').then((value){
      return value;
    });
  }

  Future<void> callback() async {
    QuerySnapshot querySnapshot = await _firestore
        .collection("users")
        .where("email", isEqualTo: (await _auth.currentUser()).email)
        .getDocuments();
    List<DocumentSnapshot> list = querySnapshot.documents;
    if (messageController.text.length > 0) {
      //print("ayush");
      print(channel);
      DocumentReference reference = await _firestore
          .collection("chats")
          .document(channel)
          .collection("messages")
          .add({'text': messageController.text, 'from': list[0].data["name"]});
      print(reference.documentID);
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
    if (widget.channel == null) {
      channel = "general";
    } else {
      channel = widget.channel;
    }
    messageController = new TextEditingController();
    scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CreateChatRoom()),
                                  );
                                },
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
                        child: Column(
                          children: <Widget>[
                            Row(children: <Widget>[
                            Elevation95(
                                child: Container(
                                    height: 30,
                                    width: MediaQuery.of(context).size.width,
                                    child: Text(
                                      widget.channel != null
                                          ? channel
                                          : "general",
                                      style: TextStyle(fontSize: 28),
                                    ))),
                            Button95(
                              onTap: (){},
                              child: Text('Translate'),
                            ),
                            ]),
                            StreamBuilder(
                              stream: _firestore
                                  .collection("chats")
                                  .document(channel)
                                  .collection("messages")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData)
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );

                                List<DocumentSnapshot> docs =
                                    snapshot.data.documents;
                                print(docs.length);
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
                          ],
                        )),
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
                              controller: messageController,
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
                                  onTap: () {
                                    print("ayush");
                                    callback();
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
                                ),
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
                            child: Row(
                              children: <Widget>[
                                Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.14,
                                    child: Elevation95(
                                        child: GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              child: Image.asset(
                                                  'assets/flutterLogo.png'),
                                            )))),
                                Elevation95(
                                    child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.07,
                                        child: Center(
                                          child: Text(
                                            "CHATROOM",
                                            style: TextStyle(fontSize: 30),
                                          ),
                                        )))
                              ],
                            )),
                      ),
                    ),
                  ],
                ))),
      ),
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
    return ListTile(
      leading: Icon(
        Icons.person_outline,
        color: Colors.black,
        size: 25,
      ),
      title: Text(
        widget.name,
        style: TextStyle(fontSize: 24),
      ),
      subtitle: Text(
        widget.message,
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
