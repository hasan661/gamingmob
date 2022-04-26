import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamingmob/authentication/providers/authprovider.dart';
import 'package:gamingmob/authentication/screens/email_verfication.dart';
import 'package:gamingmob/authentication/screens/login_screen.dart';

import 'package:gamingmob/helper.dart';
import 'package:provider/provider.dart';

class RegisterScreenItem extends StatefulWidget {
  const RegisterScreenItem({Key? key}) : super(key: key);

  @override
  State<RegisterScreenItem> createState() => _RegisterScreenItemState();
}

class _RegisterScreenItemState extends State<RegisterScreenItem> {
  void scaffold(text) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("$text")));
  }

  final firstName = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  Future<void> onRegisterButtonPressed() async {
    final isValid = _formkey.currentState!.validate();
    FirebaseAuth.instance.currentUser == null
        ? null
        : FirebaseAuth.instance.currentUser!.reload();

    if (isValid) {
      try {
        var currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser == null || email.text != currentUser.email) {
          await Provider.of<AuthProvider>(context, listen: false).registerEmail(
              email, password, firstName.text + " " + lastName.text);
          Navigator.of(context).pushNamed(EmailVerification.routeName);
        } else {
          Navigator.of(context).pushNamed(EmailVerification.routeName);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == "network-request-failed") {
          scaffold("Please check your internet connection");
        } else if (e.code == "email-already-in-use") {
          scaffold("Email already in use");
        }
        else{
          scaffold(e.code);
        }
      } catch (_) {
        scaffold(
          "Something Went Wrong",
        );
      }
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: Form(
        key: _formkey,
        child: Column(
          children: [
            SizedBox(
              height: height * 0.076,
              child: TextFormField(
                
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please provide your first name";
                  }
                  return null;
                },
                controller: firstName,
                textInputAction: TextInputAction.next,
                toolbarOptions:
                    const ToolbarOptions(cut: true, copy: true, paste: true),
                decoration: InputDecoration(
                  hintText: "First Name",
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please provide your last name";
                  }
                  return null;
                },
                controller: lastName,
                textInputAction: TextInputAction.next,
                toolbarOptions:
                    const ToolbarOptions(cut: true, copy: true, paste: true),
                decoration: InputDecoration(
                  hintText: "Last Name",
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please provide an email";
                  } else if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)) {
                    return "Please Enter A Valid Email Address";
                  }
                  return null;
                },
                controller: email,
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password is missing";
                  } else if (value.length <= 10) {
                    return "your password length should be atleast 10 characters";
                  }
                  return null;
                },
                controller: password,
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
              height: height * 0.009,
            ),
            SizedBox(
              height: height * 0.076,
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "please confirm your password";
                  } else if (password.text != confirmPassword.text) {
                    return "passwords do not match";
                  }
                  return null;
                },
                controller: confirmPassword,
                textInputAction: TextInputAction.next,
                toolbarOptions:
                    const ToolbarOptions(cut: true, copy: true, paste: true),
                decoration: InputDecoration(
                  hintText: "Confirm Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.019,
            ),
            SizedBox(
              height: height * 0.06,
              width: width,
              child: ElevatedButton(
                onPressed: () async {
                  onRegisterButtonPressed();
                },
                child: const Text("Continue"),
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
    );
  }
}