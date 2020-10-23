import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:linux_api/screens/login_screen.dart';
import 'package:linux_api/screens/register_screen.dart';
import 'package:linux_api/screens/signIn.dart';
import 'package:linux_api/screens/terminal.dart';
import 'package:linux_api/screens/start.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        Terminal.id: (context) => Terminal(),
        RegisterSreen.id: (context) => RegisterSreen(),
        SignInScreen.id: (context) => SignInScreen(),
      },
    );
  }
}
