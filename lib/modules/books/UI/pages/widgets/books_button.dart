import 'package:flutter/material.dart';

class BooksButton extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Function()? ontap;
  final IconData? icon;
  const BooksButton(
      {super.key,
      required this.label,
      required this.backgroundColor,
      required this.ontap,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: icon == null
            ? Text(
                label,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              )
            : Row(
              children: [
                Expanded(
                  child: Text(
                      label,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                ),
                Icon(icon, color: Colors.white,)
              ],
            ),
      ),
    );
  }
}