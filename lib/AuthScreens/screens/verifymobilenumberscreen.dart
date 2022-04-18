import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gamingmob/AuthScreens/providers/authprovider.dart';
import 'package:gamingmob/Helper/helper.dart';
// import 'package:musgreet/registerflow/screens/second_process_registration.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class MobileVerification extends StatefulWidget {
  
  const MobileVerification({Key? key}) : super(key: key);

  @override
  _MobileVerificationState createState() => _MobileVerificationState();
}

class _MobileVerificationState extends State<MobileVerification> {
  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();
  StreamController<ErrorAnimationType>? errorController;
  var otp=TextEditingController();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  bool checkBoxValue = false;

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: ListView(
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
        Container(
                padding: const EdgeInsets.only(left: 5),
                child: Column(
                  children: [
                    const Text(
                      " Confirm",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Please Enter the 6 digit code sent to",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Form(
                      key: formKey,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 25.0, horizontal: 40),
                          child: PinCodeTextField(
                            
                            appContext: context,
                            
                            length: 6,
                            obscureText: true,
                            obscuringCharacter: '*',
                            animationType: AnimationType.fade,
                            validator: (v) {
                              if (v!.length < 3) {
                                return "";
                              } else {
                                return null;
                              }
                            },
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(5),
                              fieldHeight: 60,
                              fieldWidth: 50,
                              
                            ),
                            cursorColor: Colors.black,
                            animationDuration:
                                const Duration(milliseconds: 300),
                            enablePinAutofill: true,
                            errorAnimationController: errorController,
                            controller: otp,
                            keyboardType: TextInputType.number,
                            onCompleted: (v) {},
                            onChanged: (value) {
                              setState(() {
                                currentText = value;
                              });
                            },
                            beforeTextPaste: (text) {
                              return true;
                            },
                          )),
                    ),
                    const Text(
                      "This code will expire in 5 minutes",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    const SizedBox(height: 40),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "Resend Code",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )),
            const SizedBox(
              height: 40,
            ),
             Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
               child: SizedBox(
                       height: height * 0.06,
                       width: width,
                       child: ElevatedButton(
                         onPressed: () async {
                Provider.of<AuthProvider>(context, listen: false).verifyOTP(otp.text);
                         },
                         child: const Text("Verify and continue"),
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
             ),
            
          ],
        ),
      ),
    );
  }
}
