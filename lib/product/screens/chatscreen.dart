import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);
  static const routeName = "/Chat";

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Chat"),
    );
  }
}
