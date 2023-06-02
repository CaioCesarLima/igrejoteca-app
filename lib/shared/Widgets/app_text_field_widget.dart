import 'package:flutter/material.dart';

class AppTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool obscure;
  const AppTextFieldWidget({super.key, required this.controller, this.obscure = false});

  @override
  Widget build(BuildContext context) {
    return  TextField(
      controller: controller,
      obscureText: obscure,
    );
  }
}