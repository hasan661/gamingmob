import 'package:flutter/material.dart';
import 'package:gamingmob/Helper/helper.dart';
import 'package:gamingmob/authentication/widgets/registerscreenitem.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const routeName = "/registerscreen";

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.25,
                child: Helper.appLogo,
              ),
              const RegisterScreenItem()
            ],
          ),
        ),
      ),
    );
  }
}
