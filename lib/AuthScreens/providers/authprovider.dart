import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool isEmailVerified = false;

  login(emailController, passwordController) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
  }

  registerEmail(email, password) async {
    final _auth = FirebaseAuth.instance;

    await _auth.createUserWithEmailAndPassword(
        email: email.text.trim(), password: password.text);
  }

  checkIsEmailVerified(timer, context) {
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendEmailVerification(context);
      timer = Timer.periodic(const Duration(seconds: 3), (_) {
        checkEmailVerified(timer);
      });
    }

    notifyListeners();
  }

  Future checkEmailVerified(timer) async {
    await FirebaseAuth.instance.currentUser!.reload();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (isEmailVerified) timer!.cancel();
    notifyListeners();
  }

  Future sendEmailVerification(context) async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  emailVerified() {
    print(isEmailVerified);
    return isEmailVerified;
  }
}
