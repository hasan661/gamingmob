import 'package:flutter/material.dart';

class ElevatedButtonStyled extends StatelessWidget {
  const ElevatedButtonStyled({Key? key, required this.shownText,required this.onPressed})
      : super(key: key);
  final String shownText;
  final  onPressed;

  

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.06,
      width: width,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(shownText),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor.withOpacity(1)),
            shape: MaterialStateProperty.all(
              
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),

            ),
            
          ),
          
        ),
      ),
    );
  }
}
