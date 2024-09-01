import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:point_of_sales/Utils/AppColors.dart';

class AppContainer extends StatelessWidget {
  Widget child;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final Alignment? alignment;
  final BoxConstraints? constraints;
  AppContainer(
      {super.key,
      this.height,
      this.width,
      this.padding,
      this.alignment,
      this.constraints,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      constraints: constraints,
      alignment: alignment,
      decoration: BoxDecoration(
          color: Appcolors.containerColor,
          border: Border.all(color: Color.fromRGBO(51, 51, 51, 1), width: 1),
          borderRadius: BorderRadius.circular(15)),
      child: child,
    );
  }
}
