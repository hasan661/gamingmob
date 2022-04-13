import 'package:flutter/material.dart';
import 'package:gamingmob/AuthScreens/providers/authprovider.dart';
import 'package:gamingmob/AuthScreens/screens/email_verfication.dart';
import 'package:gamingmob/AuthScreens/screens/login_screen.dart';
import 'package:gamingmob/Helper/helper.dart';
import 'package:provider/provider.dart';

class RegisterScreenItem extends StatefulWidget {
  const RegisterScreenItem({Key? key}) : super(key: key);

  @override
  State<RegisterScreenItem> createState() => _RegisterScreenItemState();
}

class _RegisterScreenItemState extends State<RegisterScreenItem> {
  final firstName = TextEditingController();

  final lastName = TextEditingController();

  final email = TextEditingController();

  final password = TextEditingController();

  final confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: Column(
        children: [
          SizedBox(
            height: height * 0.076,
            child: TextFormField(
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
                await Provider.of<AuthProvider>(context, listen: false)
                    .registerEmail(email, password);
                Navigator.of(context).pushNamed(EmailVerification.routeName);
              },
            child: const Text("Continue"),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor.withOpacity(1)),
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
                "Already Have An Account?",
                style: TextStyle(color: Colors.black),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, LoginScreen.routeName);
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
    );
  }
}
