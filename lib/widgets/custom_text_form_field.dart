import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final IconData iconType;
  final bool obsecureText;
  final Function onClick;
  String initialValue;
  String _errorMessage(String str) {
    switch (hintText) {
      case 'Email':
        return '*Email is required';
      case 'Name':
        return '*Name is required';
      case 'Password':
        return '*Password is required';
    }
  }

  CustomTextFormField({
    this.hintText,
    this.iconType,
    this.obsecureText = false,
    @required this.onClick,
    this.initialValue,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return _errorMessage(hintText);
          //ignore return message
        }
      },
      initialValue: initialValue,
      onSaved: onClick,
      obscureText: obsecureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        filled: true,
        fillColor: Color(0xFFe7edeb),
        hintText: hintText,
        prefixIcon: Icon(
          iconType,
          color: Colors.grey[600],
        ),
      ),
    );
  }
}
