import 'package:flutter/material.dart';
import 'package:gamingmob/authentication/widgets/mobilenumberinput.dart';
class MobileNumberInputScreen extends StatelessWidget {
  const MobileNumberInputScreen({Key? key}) : super(key: key);
  static const routeName="/mobilenumberinput";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MobileNumberInput(),
    );
  }
}
