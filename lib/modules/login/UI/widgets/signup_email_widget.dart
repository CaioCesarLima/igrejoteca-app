import 'package:flutter/material.dart';
import 'package:igrejoteca_app/shared/Widgets/app_text_field_widget.dart';
import 'package:igrejoteca_app/shared/Widgets/app_text_main_widget.dart';

class SignupEmailWidget extends StatelessWidget {
  final TextEditingController controller;
  const SignupEmailWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppTextMainWidget(text: "Qual é o seu email?"),
        AppTextFieldWidget(controller: controller)

      ],
    );
  }
}