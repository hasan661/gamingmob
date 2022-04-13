// import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamingmob/AuthScreens/providers/authprovider.dart';
import 'package:gamingmob/AuthScreens/screens/register_screen.dart';
import 'package:gamingmob/Helper/helper.dart';
import 'package:gamingmob/product/screens/producthomescreen.dart';
import 'package:provider/provider.dart';
// import 'package:gamingmob/widgets/textfieldstyled.dart';

class LoginScreenItem extends StatefulWidget {
  const LoginScreenItem({Key? key}) : super(key: key);

  @override
  State<LoginScreenItem> createState() => _LoginScreenItemState();
}

class _LoginScreenItemState extends State<LoginScreenItem> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: Column(
        children: [
          SizedBox(
            height: height * 0.076,
            child: TextFormField(
              controller: emailController,
              textInputAction: TextInputAction.next,
              toolbarOptions:
                  const ToolbarOptions(cut: true, copy: true, paste: true),
              decoration: InputDecoration(
                hintText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.009,
          ),
          SizedBox(
            height: height * 0.076,
            child: TextFormField(
              controller: passwordController,
              textInputAction: TextInputAction.next,
              toolbarOptions:
                  const ToolbarOptions(cut: true, copy: true, paste: true),
              decoration: InputDecoration(
                hintText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * (0.009+0.05),
          ),
          
          SizedBox(
            height: height * 0.06,
            width: width,
            child: ElevatedButton(
              onPressed: () async {
                try {
                  await Provider.of<AuthProvider>(context, listen: false).login(emailController, passwordController);
                  Navigator.of(context)
                      .pushReplacementNamed(ProductHomeScreen.routeName);
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
              child: const Text("Login"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).primaryColor.withOpacity(1)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.05,
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
            padding: EdgeInsets.only(top: height * 0.01, bottom: height * 0.01),
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
    );
  }
}
