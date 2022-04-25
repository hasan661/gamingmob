import 'package:flutter/material.dart';
class Helper{
  static final appLogo=Image.asset("assets/images/GamingMob.png");
  static Widget getSocialLogin(height, imageName){
    return   
      CircleAvatar(
        radius: height * 0.04,
        backgroundColor: Colors.white,
        child: Image.asset(
          "assets/images/$imageName",
        ),
      );
    

  }

}