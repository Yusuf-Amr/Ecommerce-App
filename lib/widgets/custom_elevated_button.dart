import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopper/constants.dart';
import 'package:shopper/widgets/custom_text.dart';

class CustomElevatedButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final double width;
  final double sizedBoxWidthBetweenTextAndIcon;
  final double height;
  final IconData icon;
  const CustomElevatedButton(
      {this.onPressed, this.text, this.width = 300, this.height, this.icon, this.sizedBoxWidthBetweenTextAndIcon});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            primary: Color(kPurpleColor), onPrimary: Colors.white),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14,),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              CustomText(
                text: text,
                fontWeight: FontWeight.bold,
              ),
              
              
            ]),
          ),
        ),
      
    );
  }
}
