import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Function()? ontap;
  final IconData? icon;
  final bool? loading;
  const AppButton(
      {super.key,
      required this.label,
      required this.backgroundColor,
      required this.ontap,
      this.icon,
      this.loading});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: icon == null
            ? loading != null
                ? const CircularProgressIndicator(color: Colors.white,)
                : Text(
                    label,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )
            : Row(
                children: [
                  Expanded(
                    child: Text(
                      label,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  Icon(
                    icon,
                    color: Colors.white,
                  )
                ],
              ),
      ),
    );
  }
}
