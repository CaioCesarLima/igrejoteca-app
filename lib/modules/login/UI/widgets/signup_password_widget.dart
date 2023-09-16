import 'package:flutter/material.dart';
import 'package:igrejoteca_app/modules/login/store/atoms/signup_atoms.dart';
import 'package:igrejoteca_app/shared/Widgets/app_text_field_widget.dart';
import 'package:igrejoteca_app/shared/Widgets/app_text_main_widget.dart';

class SignupPasswordWidget extends StatefulWidget {
  final TextEditingController controller;
  const SignupPasswordWidget({super.key, required this.controller});

  @override
  State<SignupPasswordWidget> createState() => _SignupPasswordWidgetState();
}

class _SignupPasswordWidgetState extends State<SignupPasswordWidget> {
  String? get _errorTextPassword {
    final text = widget.controller.value.text;
    if (text.isEmpty) {
      return 'Precisa usar alguma senha';
    }
    if (widget.controller.text.length < 6) {
      return 'Senha muito pequena';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppTextMainWidget(text: "Agora escolha uma senha segura"),
        ValueListenableBuilder(
          valueListenable: widget.controller,
          builder: (context, value, child) {
            return AppTextFieldWidget(
              controller: widget.controller,
              obscure: true,
              errorText: _errorTextPassword,
              onChanged: (value) {
                if (_errorTextPassword == null) {
                  changeNextButton.setValue(true);
                } else {
                  changeNextButton.setValue(false);
                }
              },
            );
          },
        )
      ],
    );
  }
}
