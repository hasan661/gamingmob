import 'package:flutter/material.dart';
import 'package:gamingmob/AuthScreens/screens/email_verfication.dart';
import 'package:gamingmob/AuthScreens/screens/login_screen.dart';
import 'package:gamingmob/Helper/helper.dart';
import 'package:gamingmob/widgets/elevatedbuttonstyled.dart';
import 'package:gamingmob/widgets/textfieldstyled.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const routeName = "/registerscreen";

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: height,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.25,
                child: Helper.appLogo,
              ),
              const TextFieldStyled(
                hintText: "First Name",
              ),
              const TextFieldStyled(
                hintText: "Last Name",
              ),
              const TextFieldStyled(
                hintText: "Email",
              ),
              const TextFieldStyled(
                hintText: "Password",
              ),
              const TextFieldStyled(
                hintText: "Confirm Password",
              ),
              SizedBox(
                height: height * 0.01,
              ),
              ElevatedButtonStyled(
                shownText: "Continue",
                onPressed: (){
                  Navigator.of(context).pushNamed(EmailVerification.routeName);

              },
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Helper.getSocialLogin(height, "google.png"),
                  SizedBox(
                    width: width * 0.05,
                  ),
                  Helper.getSocialLogin(height, "facebook.png")
                ],
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: height * 0.01, bottom: height * 0.01),
                child: const Text("Use Social To Login"),
              ),
              SizedBox(
              height: height * 0.03,
            ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Already Have An Account?",
                    style: TextStyle(color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, LoginScreen.routeName);
                    },
                    child: Text(
                      "Login Now",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor.withOpacity(1)),
                    ),
                  ),
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
