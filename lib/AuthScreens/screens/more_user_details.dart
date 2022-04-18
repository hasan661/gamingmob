import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamingmob/AuthScreens/providers/authprovider.dart';
import 'package:gamingmob/AuthScreens/screens/verifymobilenumberscreen.dart';
import 'package:gamingmob/Helper/helper.dart';
import 'package:gamingmob/product/screens/producthomescreen.dart';
import 'package:provider/provider.dart';

class MoreUserDetails extends StatefulWidget {
  const MoreUserDetails({Key? key}) : super(key: key);
  static const routeName = "/moreuserdetails";

  @override
  State<MoreUserDetails> createState() => _MoreUserDetailsState();
}

class _MoreUserDetailsState extends State<MoreUserDetails> {
  String verificationID = "";

  var phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    

    
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return  authProvider.isVerificationIdNull()
        ?
         Scaffold(
      body:  Padding(
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
                onPressed: () async {
                  await authProvider.registerPhone(phoneNumberController);
                },
                child: const Text("Verify"),
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
    ):const MobileVerification();
  }
}
