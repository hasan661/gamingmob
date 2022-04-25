import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool isEmailVerified = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  String? verificationID;

  Future<void> login(emailController, passwordController) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
    notifyListeners();
  }

  Future<void> registerEmail(
    email,
    password,
    name,
  ) async {
    verificationID = null;
    final _auth = FirebaseAuth.instance;

    await _auth
        .createUserWithEmailAndPassword(
            email: email.text.trim(), password: password.text)
        .then((value) {
      value.user!.updateDisplayName(name.toString());
    });
    notifyListeners();
  }

  checkIsEmailVerified(timer, context) {
    verificationID = null;
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendEmailVerification(context);
      timer = Timer.periodic(const Duration(seconds: 3), (_) {
        checkEmailVerified(timer);
      });
    }
    notifyListeners();
  }
  Future sendEmailVerification(context) async {
    try {
      verificationID = null;
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

  Future checkEmailVerified(timer) async {
    await FirebaseAuth.instance.currentUser!.reload();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (isEmailVerified) timer!.cancel();
    notifyListeners();
  }

  

  emailVerified() {
    return isEmailVerified;
  }

  Future<void> registerPhone(phoneNumberController) async {
    await FirebaseAuth.instance.currentUser!.reload();
    var userInfo = auth.currentUser;

    await auth.verifyPhoneNumber(
      phoneNumber: "+92" + phoneNumberController.text,
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
        verificationID = null;
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

  Future<void> verifyOTP(smsCode) async {
    await FirebaseAuth.instance.currentUser!.reload();
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID ?? "", smsCode: "$smsCode");

    var currentUser = auth.currentUser;
    await currentUser!.linkWithCredential(credential);
    notifyListeners();
  }

  bool isVerificationIdNull() {
    return verificationID == null;
  }

  Future<void> logoutUser()async{
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }
}
