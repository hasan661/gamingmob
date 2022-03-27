import 'package:flutter/material.dart';
import 'package:gamingmob/AuthScreens/screens/login_screen.dart';
import 'package:gamingmob/product/screens/producthomescreen.dart';
import 'package:gamingmob/Helper/helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateHome();
  }

  navigateHome() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {});
    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Helper.appLogo,
      ),
    );
  }
}
