import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:point_of_sales/Utils/AppColors.dart';

class AppContainer extends StatelessWidget {
  Widget child;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final Alignment? alignment;
  final Color? bgColor;
  final Color? borderColor;
  final double elevation;

  final BoxConstraints? constraints;
  AppContainer(
      {super.key,
      this.height,
      this.width,
      this.padding,
      this.alignment,
      this.constraints,
      this.bgColor,
      this.borderColor,
      this.elevation = 0,
      required this.child});

  @override
  Widget build(BuildContext context) {
    Color bg = bgColor ?? Appcolors.containerColor;
    Color border = borderColor ?? Appcolors.borderColor;
    return Material(
      elevation: elevation,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        height: height,
        width: width,
        padding: padding,
        constraints: constraints,
        alignment: alignment,
        decoration: BoxDecoration(
            color: bg,
            border: Border.all(color: border, width: 1),
            borderRadius: BorderRadius.circular(18)),
        child: child,
      ),
    );
  }
}
