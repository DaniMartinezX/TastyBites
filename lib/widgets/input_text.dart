import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final bool obscureText, borderEnabled;
  const InputText(
      {super.key,
      this.label = "",
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.borderEnabled = true});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: borderEnabled ? null : InputBorder.none,
        labelText: label,
        labelStyle: const TextStyle(
          color: Colors.black38,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
