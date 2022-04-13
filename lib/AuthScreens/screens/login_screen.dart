import 'package:flutter/material.dart';
import 'package:gamingmob/AuthScreens/widgets/loginscreenitem.dart';
import 'package:gamingmob/Helper/helper.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = "/loginScreen";

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          width: width,
          child: Column(
            children: [
              SizedBox(
                height: height * 0.0663,
              ),
              SizedBox(
                height: height * 0.2,
                child: Helper.appLogo,
              ),
              SizedBox(
                height: height * 0.0663,
              ),
              Text(
                "Login",
                style: GoogleFonts.questrial(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              const LoginScreenItem()
            ],
          ),
        ),
      ),
    ));
  }
}
