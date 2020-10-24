import 'package:flutter/material.dart';
import 'package:linux_api/Pages/TerminalChat.dart';
import 'package:linux_api/components/roundedButtons.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../constants.dart';
import '../http.dart';

class LinuxLoginScreen extends StatefulWidget {
  static String id = 'Linux';
  @override
  _LinuxLoginScreenState createState() => _LinuxLoginScreenState();
}

class _LinuxLoginScreenState extends State<LinuxLoginScreen> {
  String username;
  String ipAddress;
  String command;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe8ffff),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                onChanged: (value) {
                  ipAddress = value;
                },
                decoration:
                    kTextFieldDec.copyWith(hintText: 'Enter Your IP Address'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                onChanged: (value) {
                  username = value;
                },
                decoration:
                    kTextFieldDec.copyWith(hintText: 'Enter Your Username'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                  title: 'Log In to Terminal',
                  color: Color(0xff41aea9),
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      if (username == 'root') {
                        Navigator.pushNamed(context, TerminalChat.id);
                      } else {
                        command = 'su - $username';
                        HTTP(
                            'http://192.168.43.161/cgi-bin/myCGI.py?x=$command');
                        Navigator.pushNamed(context, TerminalChat.id);
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
