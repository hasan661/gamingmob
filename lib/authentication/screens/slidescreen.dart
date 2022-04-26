import 'package:flutter/material.dart';
import 'package:gamingmob/authentication/screens/login_screen.dart';
import 'package:gamingmob/helper.dart';
class SlideScreen extends StatefulWidget {
  const SlideScreen({ Key? key }) : super(key: key);

  @override
  State<SlideScreen> createState() => _SlideScreenState();
}

class _SlideScreenState extends State<SlideScreen> {
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