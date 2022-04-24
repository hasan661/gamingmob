import 'package:flutter/material.dart';
import 'package:gamingmob/AuthScreens/providers/authprovider.dart';
import 'package:gamingmob/Helper/helper.dart';
import 'package:provider/provider.dart';

class EmailVerificationItem extends StatelessWidget {
  const EmailVerificationItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          body: SizedBox(
        height: height,
        width: width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.02,
              ),
              SizedBox(
                height: height * 0.2,
                child: Helper.appLogo,
              ),
              SizedBox(
                height: height * 0.2,
              ),
              SizedBox(
                width: width * 0.8,
                child: const Text(
                  "An email verification link is sent to your procided email. Click on that link to verify your email. You will automatically be verified",
                  textAlign: TextAlign.justify,
                ),
              ),
              const Expanded(child: SizedBox()),
              SizedBox(
                height: height * 0.06,
                width: width,
                child: ElevatedButton(
                  onPressed: () {
                    Provider.of<AuthProvider>(context, listen: false).sendEmailVerification(context);
                  },
                  child: const Text("Resend Email"),
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
            ],
          ),
        ),
      )),
    );
  }
}
