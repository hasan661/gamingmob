import 'package:flutter/material.dart';
import 'package:gamingmob/AuthScreens/screens/more_user_details.dart';

class EmailVerification extends StatelessWidget {
  const EmailVerification({Key? key}) : super(key: key);
  static const routeName = "/emailverification";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: GestureDetector(
            onTap: (){
              Navigator.of(context).pushNamed(MoreUserDetails.routeName);
            },

            child: const Text(
              "Email Verification Screen Touch To Navigate",
            ),
          ),
        ),
      ),
    );
  }
}
