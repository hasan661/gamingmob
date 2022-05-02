import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:gamingmob/nointerent.dart';
class InterentCheckStream extends StatelessWidget {
  const InterentCheckStream({ Key? key , required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(builder: (context, snapshot) {
      
        if(snapshot.data==ConnectivityResult.none){
          return const NoInterentScreen();
        }
        else{
          return child;
        }
      
    },stream: Connectivity().onConnectivityChanged,);
  }
}