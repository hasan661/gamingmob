import 'package:flutter/material.dart';

class MyAdScreen extends StatelessWidget {
  const MyAdScreen({Key? key}) : super(key: key);
  static const routeName="/MyAds";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text("My Ads"),
      ),
    );
  }
}
