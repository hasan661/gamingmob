import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamingmob/Helper/helper.dart';
import 'package:gamingmob/authentication/providers/authprovider.dart';
import 'package:gamingmob/authentication/screens/email_verfication.dart';
import 'package:gamingmob/authentication/screens/register_screen.dart';
import 'package:gamingmob/authentication/widgets/mobilenumberinput.dart';
import 'package:gamingmob/product/screens/productscategoryscreen.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginScreenItem extends StatefulWidget {
  const LoginScreenItem({Key? key}) : super(key: key);

  @override
  State<LoginScreenItem> createState() => _LoginScreenItemState();
}

class _LoginScreenItemState extends State<LoginScreenItem> {
  final _formKey = GlobalKey<FormState>();
  onLoginButtonPressed() async {
    var isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    var currentUser = FirebaseAuth.instance.currentUser;
    try {
      if (currentUser == null) {
        await Provider.of<AuthProvider>(context, listen: false)
            .login(emailController, passwordController);
      } else if (currentUser.email == emailController.text &&
          !currentUser.emailVerified) {
        Navigator.of(context).pushNamed(EmailVerification.routeName);
      } else if (currentUser.email == emailController.text &&
          currentUser.phoneNumber == null) {
        Navigator.of(context).pushNamed(MobileNumberInput.routeName);
      } else {
        await Provider.of<AuthProvider>(context, listen: false)
            .login(emailController, passwordController);
      }
    } on FirebaseException catch (e) {
      if (e.code == "wrong-password") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
             backgroundColor: Theme.of(context).errorColor,
            duration: const Duration(days: 365),
            content:const Text("invalid password"),
            action: SnackBarAction(label: "Close",onPressed: (){
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              
              
            },textColor: Colors.white),
          ),
        );
      } else if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
              backgroundColor: Theme.of(context).errorColor,
             
            duration:const Duration(days: 365),
            content:const Text("Email does not exist"),
             action: SnackBarAction(label: "Close",onPressed: (){
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              
              
            },textColor: Colors.white),
          ),
        );
      }
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration:const  Duration(days: 365),
        backgroundColor: Theme.of(context).errorColor,
        content:const  Text(
          "Something went wrong",
        ),
         action: SnackBarAction(label: "Close",onPressed: (){
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              
              
            },textColor: Colors.white),
      ));
    }
  }

  onGoogleButtonPressed() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser!.phoneNumber == null || currentUser.phoneNumber == "") {
      Navigator.of(context).pushNamed(MobileNumberInput.routeName);
    } else {
      Navigator.of(context).pushNamed(ProductCategoriesScreen.routeName);
    }
  }

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ListView(
        children: [
          Column(
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Email Field Is Required";
                              } else if (!RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(val)) {
                                return "Please Enter A Valid Email Address";
                              }
                              return null;
                            },
                            controller: emailController,
                            textInputAction: TextInputAction.next,
                            toolbarOptions: const ToolbarOptions(
                                cut: true, copy: true, paste: true),
                            decoration: InputDecoration(
                              hintText: "Email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              constraints: BoxConstraints(
                                minHeight: height * 0.076,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.009,
                          ),
                          TextFormField(
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Password Field Is Required";
                              }
                              return null;
                            },
                            controller: passwordController,
                            textInputAction: TextInputAction.next,
                            toolbarOptions: const ToolbarOptions(
                                cut: true, copy: true, paste: true),
                            decoration: InputDecoration(
                              hintText: "Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              constraints: BoxConstraints(
                                minHeight: height * 0.076,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * (0.009 + 0.05),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        onLoginButtonPressed();
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
                          fixedSize: MaterialStateProperty.all(
                              Size(width, height * 0.06))),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await Provider.of<AuthProvider>(context,
                                    listen: false)
                                .googleLogin();
                            onGoogleButtonPressed();
                          },
                          child: Helper.getSocialLogin(
                            height,
                            "google.png",
                          ),
                        ),
                        SizedBox(
                          width: width * 0.05,
                        ),
                        GestureDetector(
                          onTap: () {
                            Provider.of<AuthProvider>(context, listen: false)
                                .signInWithFacebook();
                            onGoogleButtonPressed();
                          },
                          child: Helper.getSocialLogin(
                            height,
                            "facebook.png",
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: height * 0.01, bottom: height * 0.04),
                      child: const Text("Use Social To Login"),
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
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(1)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
