import 'package:flutter/material.dart';
import 'package:gamingmob/Helper/helper.dart';

class MoreUserDetails extends StatelessWidget {
  const MoreUserDetails({Key? key}) : super(key: key);
  static const routeName = "/moreuserdetails";

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.11,
                  child: TextFormField(
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
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
