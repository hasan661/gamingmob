import 'package:flutter/material.dart';

class TextFieldStyled extends StatelessWidget {
  const TextFieldStyled({Key? key, required this.hintText, }) : super(key: key);
  final String hintText;
  

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: Column(
        children: [
          SizedBox(
            height: height * 0.076,
            child: TextFormField(
              textInputAction: TextInputAction.next,
              toolbarOptions:
                  const ToolbarOptions(cut: true, copy: true, paste: true),
              decoration: InputDecoration(
                hintText: hintText,
                
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
    );
  }
}
