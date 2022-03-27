import 'package:flutter/material.dart';
import 'package:gamingmob/AuthScreens/screens/register_screen.dart';
import 'package:gamingmob/Helper/helper.dart';
import 'package:gamingmob/widgets/elevatedbuttonstyled.dart';
import 'package:gamingmob/widgets/textfieldstyled.dart';
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
      body: SizedBox(
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
            const TextFieldStyled(
              hintText: "Email",
            ),
            const TextFieldStyled(
              hintText: "Password",
            ),
            SizedBox(
              height: height * 0.05,
            ),
            ElevatedButtonStyled(
              shownText: "Login",
              onPressed: (){

              },
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Helper.getSocialLogin(height,"google.png"),
               
                SizedBox(
                  width: width * 0.05,
                ),
                Helper.getSocialLogin(height,"facebook.png")
                
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
                  "Do have an account ?",
                  style: TextStyle(color: Colors.black),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, RegisterScreen.routeName);
                  },
                  child: Text(
                    "Register Now",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor.withOpacity(1)),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.03,
            ),
          ],
        ),
      ),
    ));
  }
}
