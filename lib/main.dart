import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Pages/LinuxLogin.dart';
import 'Pages/Register.dart';
import 'Pages/SignIn.dart';
import 'Pages/TerminalChat.dart';
import 'Pages/Welcome.dart';

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
        LinuxLoginScreen.id: (context) => LinuxLoginScreen(),
        TerminalChat.id: (context) => TerminalChat(),
        RegisterSreen.id: (context) => RegisterSreen(),
        SignInScreen.id: (context) => SignInScreen(),
      },
    );
  }
}
