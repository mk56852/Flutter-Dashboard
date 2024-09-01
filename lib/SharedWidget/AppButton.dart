import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  String title;
  Function onTap;
  Color bgColor;
  Color textColor;
  Color borderColor;

  AppButton(
      {super.key,
      required this.title,
      required this.bgColor,
      required this.textColor,
      required this.borderColor,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: bgColor,
            border: Border.all(color: borderColor, width: 1)),
        child: Text(
          title,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
