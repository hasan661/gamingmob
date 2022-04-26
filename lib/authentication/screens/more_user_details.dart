import 'package:flutter/material.dart';
import 'package:gamingmob/authentication/providers/authprovider.dart';
import 'package:gamingmob/authentication/widgets/mobilenumberinputitem.dart';
import 'package:gamingmob/authentication/widgets/verifymobilenumber.dart';
import 'package:provider/provider.dart';

class MoreUserDetails extends StatefulWidget {
  const MoreUserDetails({Key? key}) : super(key: key);
  static const routeName = "/moreuserdetails";

  @override
  State<MoreUserDetails> createState() => _MoreUserDetailsState();
}

class _MoreUserDetailsState extends State<MoreUserDetails> {
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MobileNumberInput()
         
    );
  }
}
