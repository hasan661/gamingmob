import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamingmob/Helper/helper.dart';
import 'package:gamingmob/product/screens/producthomescreen.dart';

class MoreUserDetails extends StatefulWidget {
  const MoreUserDetails({Key? key}) : super(key: key);
  static const routeName = "/moreuserdetails";

  @override
  State<MoreUserDetails> createState() => _MoreUserDetailsState();
}

class _MoreUserDetailsState extends State<MoreUserDetails> {
  String verificationID = "";

  FirebaseAuth auth = FirebaseAuth.instance;

  var phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void loginWithPhone() async {
      auth.verifyPhoneNumber(
        phoneNumber: "+92" + phoneNumberController.text,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential).then((value) {
            
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          
        },
        codeSent: (String verificationId, int? resendToken) {
          verificationID = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }

    void verifyOTP() async {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationID, smsCode: "36623");

      await auth
          .signInWithCredential(credential)
          .then(
            (value) {},
          )
          .whenComplete(
        () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const ProductHomeScreen(),
            ),
          );
        },
      );
    }

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
         padding: EdgeInsets.symmetric(horizontal: width * 0.05),
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
            SizedBox(
              height: height * 0.11,
              child: TextFormField(
                controller: phoneNumberController,
                textInputAction: TextInputAction.next,
                toolbarOptions: const ToolbarOptions(
                  cut: true,
                  copy: true,
                  paste: true,
                ),
                decoration: InputDecoration(
                  hintText: "Contact Number",
                  helperText: "You will need to verify your mobile number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.009,
            ),
            const Expanded(child: SizedBox()),
            SizedBox(
              height: height * 0.06,
              width: width,
              child: ElevatedButton(
                onPressed: loginWithPhone,
                child: const Text("Veify"),
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
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
