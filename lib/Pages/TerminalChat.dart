import 'package:flutter/material.dart';

class TerminalChat extends StatefulWidget {
  static String id = 'Terminal';
  @override
  _TerminalChatState createState() => _TerminalChatState();
}

class _TerminalChatState extends State<TerminalChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe8ffff),
      appBar: AppBar(
        backgroundColor: Colors.teal[300],
      ),
    );
  }
}
