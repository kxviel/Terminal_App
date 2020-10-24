import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:linux_api/Pages/Register.dart';
import 'package:linux_api/Pages/SignIn.dart';
import '../components/roundedButtons.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'Welcome';

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/code.png'),
                    height: 56.0,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ColorizeAnimatedTextKit(
                    speed: const Duration(milliseconds: 1000),
                    onTap: () {
                      print("Tap Event");
                    },
                    text: ['TermSoft'],
                    textStyle: GoogleFonts.sacramento(
                        textStyle: TextStyle(
                            fontSize: 63.0, fontWeight: FontWeight.bold)),
                    colors: [
                      Color(0xff213e3b),
                      Color(0xff41aea9),
                      Color(0xffa6f6f1),
                      Color(0xffe8ffff),
                    ],
                    textAlign: TextAlign.start,
                    alignment:
                        AlignmentDirectional.topStart // or Alignment.topLeft
                    ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'Sign In',
              color: Color(0xff41aea9),
              onPressed: () {
                Navigator.pushNamed(context, SignInScreen.id);
              },
            ),
            RoundedButton(
              title: 'Sign Up',
              color: Color(0xff41aea9),
              onPressed: () {
                Navigator.pushNamed(context, RegisterSreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
