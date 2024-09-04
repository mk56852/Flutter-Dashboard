import 'package:flutter/material.dart';
import 'package:point_of_sales/Utils/AppColors.dart';

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

class AppButtonWithIcon extends StatelessWidget {
  Color? bgColor;
  Color fontColor;
  String text;
  IconData? icon;
  double height;
  Function onPress;
  AppButtonWithIcon(
      {super.key,
      required this.text,
      this.bgColor,
      this.fontColor = Colors.white,
      this.height = 45,
      required this.onPress,
      this.icon});

  @override
  Widget build(BuildContext context) {
    Color color = bgColor ?? Appcolors.sideBarColor;
    return InkWell(
      onTap: () => onPress(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(7),
        ),
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: fontColor,
              ), // Show icon if present
              SizedBox(width: 8), // Add some spacing between icon and text
            ],
            Text(
              text,

              style:
                  TextStyle(color: fontColor), // Set the font color of the text
            ),
          ],
        ),
      ),
    );
  }
}
