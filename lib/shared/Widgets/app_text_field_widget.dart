import 'package:flutter/material.dart';

class AppTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool obscure;
  final String? errorText;
  final Function(String)? onChanged;
  const AppTextFieldWidget({super.key, required this.controller, this.obscure = false, this.errorText, this.onChanged});

  

  @override
  Widget build(BuildContext context) {
    return  TextField(
      controller: controller,
      obscureText: obscure,
      onChanged: onChanged,
      decoration: InputDecoration(
        errorText: errorText 
      ),
    );
  }
}