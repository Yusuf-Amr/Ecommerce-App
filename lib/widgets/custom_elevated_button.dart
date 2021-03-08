import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopper/widgets/custom_text.dart';

class CustomElevatedButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  const CustomElevatedButton({
    this.onPressed,
    this.text,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            primary: Color(0xFF141414), onPrimary: Colors.white),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: CustomText(text: text),
        ),
      ),
    );
  }
}
