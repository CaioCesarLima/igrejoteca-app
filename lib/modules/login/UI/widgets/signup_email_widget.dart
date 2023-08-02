import 'package:flutter/material.dart';
import 'package:igrejoteca_app/modules/login/store/atoms/signup_atoms.dart';
import 'package:igrejoteca_app/shared/Widgets/app_text_field_widget.dart';
import 'package:igrejoteca_app/shared/Widgets/app_text_main_widget.dart';
import 'package:logger/logger.dart';

class SignupEmailWidget extends StatefulWidget {
  final TextEditingController controller;
  const SignupEmailWidget({super.key, required this.controller});

  @override
  State<SignupEmailWidget> createState() => _SignupEmailWidgetState();
}

class _SignupEmailWidgetState extends State<SignupEmailWidget> {
  String? get _errorTextEmail {
    final text = widget.controller.value.text;
    if (text.isEmpty) {
      return 'Preencha o seu email';
    }
    if (!RegExp(r'^[a-z0-9._+-]+@[a-z0-9.-]+\.[a-z]{2,63}$').hasMatch(text)) {
      return 'Email inválido';
    }
    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppTextMainWidget(text: "Qual é o seu email?"),
        ValueListenableBuilder(
          valueListenable: widget.controller,
          builder: (context, value, child) {
            return AppTextFieldWidget(
              controller: widget.controller,
              errorText: _errorTextEmail,
              onChanged: (value) {
                if (_errorTextEmail == null) {
                  Logger().i("valido");
                  changeNextButton.setValue(true);
                }
              },
            );
          },
        )
      ],
    );
  }
}
