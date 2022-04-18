import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamingmob/product/screens/producthomescreen.dart';

class AuthProvider with ChangeNotifier {
  bool isEmailVerified = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  var verificationID;

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
    return isEmailVerified;
  }

  Future<void> registerPhone(phoneNumberController) async {
    var userInfo = auth.currentUser;
    await auth.verifyPhoneNumber(
      phoneNumber: "+92" + phoneNumberController.text,
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
        await userInfo!.linkWithCredential(phoneAuthCredential);
        notifyListeners();
      },
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        verificationID = verificationId;
        notifyListeners();
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void verifyOTP(smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: "$smsCode");
        

    var currentUser = auth.currentUser;
    print(currentUser);
    await currentUser!.linkWithCredential(credential);
  }

  bool isVerificationIdNull(){
    print(verificationID==null);
    return verificationID==null;
  }
}
