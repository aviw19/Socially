import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter95/flutter95.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:socially/CallPage.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  /// create a channelController to retrieve text value
  final _channelController = TextEditingController();

  /// if channel textField is validated to have error
  bool _validateError = false;

  ClientRole _role = ClientRole.Broadcaster;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Scaffold95(
        title: "VIDEOCHAT",
        canPop: true,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height*0.3,
            ),
            Container(
                margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: Text("USERNAME",
                    style: TextStyle(fontFamily: 'Orangekid', fontSize: 24))),
            Container(
              margin: EdgeInsets.fromLTRB(40, 0, 40, 20),
              child: TextField95(
                obscuretext: false,
                controller: _channelController,
              ),

            ),
            Column(
              children: [
                ListTile(
                  title: Text("Join as Member",style: TextStyle(fontSize: 20),),
                  leading: Radio(
                    value: ClientRole.Broadcaster,
                    groupValue: _role,
                    onChanged: (ClientRole value) {
                      setState(() {
                        _role = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text("Join as audience",style: TextStyle(fontSize: 20),),
                  leading: Radio(
                    value: ClientRole.Audience,
                    groupValue: _role,
                    onChanged: (ClientRole value) {
                      setState(() {
                        _role = value;
                      });
                    },
                  ),
                )
              ],
            ),
             Container(
                      margin: EdgeInsets.fromLTRB(40, 10, 40, 0),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.width * 0.12,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                  
                    child: Button95(
                      onTap: (){onJoin();},
                      child:Center(child: Text('Join',style: TextStyle(fontSize: 30)
                    ),
                  )))
                ],
              ),
            ),
        );
  
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _channelController.dispose();
    super.dispose();
  }
  Future<void> onJoin() async {
    // update input validation
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });
    if (_channelController.text.isNotEmpty) {
      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic();
      // push video page with given channel name
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(
            channelName: _channelController.text,
            role: _role,
          ),
        ),
      );
    }
  }

  Future<void> _handleCameraAndMic() async {
    await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],
    );
  }
}
