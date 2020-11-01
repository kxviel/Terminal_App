import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linux_api/Pages/Welcome.dart';
import '../constants.dart';
import 'package:ssh/ssh.dart';

final _fire = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
User loggedInUser;

class TerminalChat extends StatefulWidget {
  final String ipAddress;
  final dynamic linPass;
  static String id = 'Terminal';
  TerminalChat({this.ipAddress, this.linPass});

  @override
  _TerminalChatState createState() => _TerminalChatState();
}

class _TerminalChatState extends State<TerminalChat> {
  final controller = TextEditingController();
  var sshResult;
  String commandText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe8ffff),
      appBar: AppBar(
        backgroundColor: Color(0xff41aea9),
        actions: [
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.popUntil(
                    context, ModalRoute.withName(WelcomeScreen.id));
              }),
        ],
        title: Text('TermSoft',
            style: GoogleFonts.sacramento(
                textStyle:
                    TextStyle(fontSize: 35, fontWeight: FontWeight.bold))),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: controller,
                      onChanged: (value) {
                        commandText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      controller.clear();

                      var client = SSHClient(
                        host: widget.ipAddress,
                        port: 22,
                        username: 'root',
                        passwordOrKey: 9481,
                      );
                      try {
                        var result = await client.connect();
                        if (result == "session_connected")
                          sshResult = await client.execute(commandText);
                        client.disconnect();
                        print(sshResult);
                      } on PlatformException catch (e) {
                        print('Error: ${e.code}\nError Message: ${e.message}');
                      }

                      _fire.collection('commands').add({
                        'httpdResult': sshResult,
                        'sender': loggedInUser.email,
                      });
                    },
                    child: Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _fire.collection('commands').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.teal,
              ),
            );
          }
          QuerySnapshot querySnapshot = snapshot.data;
          final fireReply = querySnapshot.docs.reversed;
          List<MessageBubble> messageBubbles = [];

          for (var message in fireReply) {
            final messageText = message.data()['httpdResult'];
            final messageSender = message.data()['sender'];
            print('hey $messageText');
            print('hey $messageSender');
            final currentUser = loggedInUser.email;

            final messageBubble = MessageBubble(
              text: messageText,
              isMe: currentUser == messageSender,
              sender: messageSender,
            );

            messageBubbles.add(messageBubble);
          }
          return Expanded(
              child: ListView(
                  reverse: true,
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  children: messageBubbles));
        });
  }
}

class MessageBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  final String sender;

  MessageBubble({this.text, this.isMe, this.sender});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.stretch,
        children: [
          Text(
            sender,
            style: TextStyle(fontSize: 12.0, color: Colors.black54),
          ),
          Material(
            elevation: 7.0,
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))
                : BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 15.0,
                  color: isMe ? Colors.white : Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
