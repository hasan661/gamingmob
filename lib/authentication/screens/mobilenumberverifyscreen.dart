import 'package:flutter/material.dart';
import 'package:gamingmob/authentication/widgets/verifymobilenumber.dart';

class MobileNumberVerifyScreen extends StatelessWidget {
  const MobileNumberVerifyScreen({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MobileVerification(),
    );
  }
}
