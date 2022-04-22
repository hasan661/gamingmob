import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gamingmob/AuthScreens/providers/authprovider.dart';
import 'package:gamingmob/AuthScreens/widgets/emailverificationitem.dart';
import 'package:gamingmob/AuthScreens/widgets/mobilenumberinput.dart';
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
            ? const MobileNumberInput()
            : const EmailVerificationItem();
      }),
    );
  }
}
