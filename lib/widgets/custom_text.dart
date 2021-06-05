import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final String fontFamily;
  final FontWeight fontWeight;

  CustomText({this.text, this.fontSize, this.color, this.fontFamily,this.fontWeight});
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontFamily: fontFamily,
          fontWeight: fontWeight,
        ));
  }
}
