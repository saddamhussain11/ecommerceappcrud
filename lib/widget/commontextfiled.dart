import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final bool isPassword;
  final TextInputType keyboardType;

  const CommonTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.prefixIcon = Icons.text_fields, // Default icon
    this.isPassword = false,
    this.keyboardType = TextInputType.text, // Default keyboard type
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword, // For password fields
      keyboardType: keyboardType, // For different input types
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(prefixIcon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0), // Rounded border
        ),
        contentPadding: EdgeInsets.all(16.0),
      ),
    );
  }
}
