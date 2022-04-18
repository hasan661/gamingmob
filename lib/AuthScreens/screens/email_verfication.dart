import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gamingmob/AuthScreens/providers/authprovider.dart';

import 'package:gamingmob/AuthScreens/screens/more_user_details.dart';
import 'package:provider/provider.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({Key? key}) : super(key: key);
  static const routeName = "/emailverification";

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  Timer? timer;
  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) =>
        Provider.of<AuthProvider>(context, listen: false)
            .checkIsEmailVerified(timer, context));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: ((context, value, child) {
        var isEmailVerified =
            Provider.of<AuthProvider>(context, listen: false).emailVerified();
        return isEmailVerified
            ? const MoreUserDetails()
            : SafeArea(
                child: Scaffold(
                  body: Center(
                    child: GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "Email Verification Screen Touch To Navigate",
                      ),
                    ),
                  ),
                ),
              );
      }),
    );
  }
}
