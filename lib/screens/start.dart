import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:linux_api/screens/login_screen.dart';
import 'package:linux_api/screens/terminal.dart';
import '../components/roundedButtons.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe8ffff),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                child: Image.asset('images/code.png'),
                height: 57.0,
              ),
            ),
            ColorizeAnimatedTextKit(
                onTap: () {
                  print("Tap Event");
                },
                text: ['TermSoft'],
                textStyle: GoogleFonts.sacramento(
                    textStyle: TextStyle(fontSize: 60.0)),
                colors: [
                  Color(0xff213e3b),
                  Color(0xff41aea9),
                  Color(0xffa6f6f1),
                  Color(0xffe8ffff),
                ],
                textAlign: TextAlign.start,
                alignment: AlignmentDirectional.topStart // or Alignment.topLeft
                ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'Log In',
              color: Color(0xff41aea9),
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
