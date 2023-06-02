import 'package:flutter/material.dart';
import 'package:igrejoteca_app/core/theme/colors.dart';

class AppTextMainWidget extends StatelessWidget {
  final String text;
  const AppTextMainWidget({
    Key? key, required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text, 
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        color: AppColors.accentColor,
        fontSize: 18
      ),
    );
  }
}