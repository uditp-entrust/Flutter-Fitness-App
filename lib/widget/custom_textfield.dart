import 'package:flutter/material.dart';

import 'package:hamstring_design/constants.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Function validator, onSaved, onChanged;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool enabled;
  final String initialValue;
  final Icon textfieldIcon;

  CustomTextField(
      {this.hintText,
      this.keyboardType,
      this.obscureText,
      this.validator,
      this.onSaved,
      this.enabled,
      this.initialValue = '',
      this.onChanged,
      this.textfieldIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: TextFormField(
        enabled: enabled,
        initialValue: initialValue,
        validator: validator,
        onSaved: onSaved,
        onChanged: onChanged,
        keyboardType: keyboardType ?? keyboardType,
        style: customTextFieldStyle,
        obscureText: obscureText == true ?? true,
        decoration:
            InputDecoration(labelText: hintText, suffixIcon: textfieldIcon),
      ),
    );
  }
}
