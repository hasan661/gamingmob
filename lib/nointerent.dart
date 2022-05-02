import 'package:flutter/material.dart';
class NoInterentScreen extends StatelessWidget {
  const NoInterentScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("No Internet"),),
    );
  }
}