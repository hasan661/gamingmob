import 'package:flutter/material.dart';
import 'package:gamingmob/AuthScreens/providers/authprovider.dart';
import 'package:gamingmob/AuthScreens/widgets/verifymobilenumber.dart';
import 'package:gamingmob/Helper/helper.dart';
import 'package:provider/provider.dart';

class MobileNumberInput extends StatefulWidget {
  const MobileNumberInput({Key? key}) : super(key: key);
  static const routeName="mobilenumberinput";
  @override
  State<MobileNumberInput> createState() => _MobileNumberInputState();
}

class _MobileNumberInputState extends State<MobileNumberInput> {
  String verificationID = "";
  final _formkey = GlobalKey<FormState>();
  var isLoading = false;

  var phoneNumberController = TextEditingController();
  onVerifyButtonPressed(authProvider) async {
    var isValid = _formkey.currentState!.validate();
    if (isValid) {
      setState(() {
        isLoading = true;
      });
      await authProvider.registerPhone(phoneNumberController);
      setState(() {
        isLoading = false;
      });

      Navigator.of(context).pushNamed(MobileVerification.routeName);
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
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
                  Form(
                    key: _formkey,
                    child: SizedBox(
                      height: height * 0.13,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please provide a mobile number";
                          } else if (value.length != 11) {
                            return "Your number should contain 11 digits";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        controller: phoneNumberController,
                        textInputAction: TextInputAction.next,
                        toolbarOptions: const ToolbarOptions(
                          cut: true,
                          copy: true,
                          paste: true,
                        ),
                        decoration: InputDecoration(
                          hintText: "Contact Number",
                          helperMaxLines: 2,
                          helperText:
                              "You will need to verify your mobile number through an OTP send to your phone",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
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
                        onVerifyButtonPressed(authProvider);
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
    );
  }
}
