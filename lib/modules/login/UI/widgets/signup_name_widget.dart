import 'package:flutter/material.dart';
import 'package:igrejoteca_app/modules/login/store/atoms/signup_atoms.dart';
import 'package:igrejoteca_app/shared/Widgets/app_text_field_widget.dart';
import 'package:igrejoteca_app/shared/Widgets/app_text_main_widget.dart';

class SignupNameWidget extends StatelessWidget {
  final TextEditingController controller;
  const SignupNameWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppTextMainWidget(text: "Qual é o seu nome?"),
        AppTextFieldWidget(controller: controller, onChanged: (value){
          if(controller.text.length > 4){
            changeNextButton.setValue(true);
          }else{
            changeNextButton.setValue(false);
          }
        },)

      ],
    );
  }
}