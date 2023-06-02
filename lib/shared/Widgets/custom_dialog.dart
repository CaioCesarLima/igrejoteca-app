
import 'package:flutter/material.dart';
import 'package:igrejoteca_app/core/theme/colors.dart';
import 'package:igrejoteca_app/core/utils/consts.dart';
import 'package:igrejoteca_app/shared/Widgets/app_button.dart';

class CustomDialog extends StatelessWidget {
  final String text;
  const CustomDialog({
    super.key, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: Consts.khorintalPading),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(10)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      text,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primaryColor),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AppButton(
                        label: "Ok",
                        backgroundColor:
                            AppColors.accentColor,
                        ontap: () {
                          Navigator.of(context).pop();
                        })
                  ],
                ),
              ),
            );
  }
}
