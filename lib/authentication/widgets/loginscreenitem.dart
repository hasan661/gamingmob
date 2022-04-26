import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamingmob/authentication/providers/authprovider.dart';
import 'package:gamingmob/authentication/screens/email_verfication.dart';
import 'package:gamingmob/authentication/screens/register_screen.dart';
import 'package:gamingmob/authentication/widgets/mobilenumberinputitem.dart';
import 'package:gamingmob/helper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginScreenItem extends StatefulWidget {
  const LoginScreenItem({Key? key}) : super(key: key);

  @override
  State<LoginScreenItem> createState() => _LoginScreenItemState();
}

class _LoginScreenItemState extends State<LoginScreenItem> {
  onLoginButtonPressed() async {
    
    var currentUser = FirebaseAuth.instance.currentUser;
    print(currentUser);
    try {
      if (currentUser == null) {
        await Provider.of<AuthProvider>(context, listen: false)
            .login(emailController, passwordController);
      } else if (currentUser.email==emailController.text && !currentUser.emailVerified) {
        Navigator.of(context).pushNamed(EmailVerification.routeName);
      } else if (currentUser.email==emailController.text && currentUser.phoneNumber == null) {
        Navigator.of(context).pushNamed(MobileNumberInput.routeName);
      } else {
        await Provider.of<AuthProvider>(context, listen: false)
            .login(emailController, passwordController);
      }
    } on FirebaseException catch (e) {
      if (e.code == "wrong-password") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("invalid password"),
          ),
        );
      }
      else if (e.code=="user-not-found"){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Email does not exist"),
          ),
        );
      }
    } catch (_) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Something went wrong")));
    }
  }

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.076,
                        child: TextFormField(
                          controller: emailController,
                          textInputAction: TextInputAction.next,
                          toolbarOptions: const ToolbarOptions(
                              cut: true, copy: true, paste: true),
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
                          toolbarOptions: const ToolbarOptions(
                              cut: true, copy: true, paste: true),
                          decoration: InputDecoration(
                            hintText: "Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * (0.009 + 0.05),
                      ),
                      SizedBox(
                        height: height * 0.06,
                        width: width,
                        child: ElevatedButton(
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
                        padding: EdgeInsets.only(
                            top: height * 0.01, bottom: height * 0.01),
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
          ),
        ),
      ),
    );
  }
}
