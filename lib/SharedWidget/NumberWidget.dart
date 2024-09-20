import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:point_of_sales/SharedWidget/AppContainer.dart';
import 'package:point_of_sales/Utils/AppColors.dart';
import 'package:point_of_sales/Utils/AppDimension.dart';

class NumberWidget extends StatelessWidget {
  String title;
  String text;
  IconData mainIconData;
  String? description;
  Color? bgColor;
  Color? fontColor;
  Color? iconColor;
  Color? iconBgColor;
  Color? iconBorderColor;
  Color? barColors;

  NumberWidget(
      {super.key,
      required this.title,
      required this.mainIconData,
      required this.text,
      this.description,
      this.bgColor,
      this.iconBgColor,
      this.iconBorderColor,
      this.iconColor,
      this.barColors,
      this.fontColor});

  @override
  Widget build(BuildContext context) {
    Color bg = bgColor ?? Appcolors.backgroundColor;
    Color ft = fontColor ?? Colors.black;
    Color iconC = iconColor ?? Colors.white;
    Color IconBg = iconBgColor ?? Appcolors.thirdBlue;
    Color IconBorder = iconBorderColor ?? Colors.white;
    Color barC = barColors ?? Appcolors.secondBlue;
    return AppContainer(
      bgColor: bg,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      text,
                      style: TextStyle(
                          fontSize: 13, color: Appcolors.secondTextColor),
                    ),
                  ],
                )),
                ChartLogo(color: barC)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            if (description != null)
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.chartColumn,
                    size: 14,
                    color: ft,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                      description!,
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      style: TextStyle(fontSize: 13, color: ft),
                    ),
                  )
                ],
              )
          ],
        ),
      ),
    );
  }
}

class ChartLogo extends StatelessWidget {
  Color color;
  ChartLogo({super.key, required this.color});

  double getRandom() {
    int max = 40;
    double randomNumber = Random().nextInt(max) + 16;
    return randomNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 7,
          height: getRandom(),
          color: color,
        ),
        SizedBox(
          width: 3,
        ),
        Container(
          width: 7,
          height: getRandom(),
          color: color,
        ),
        SizedBox(
          width: 3,
        ),
        Container(
          width: 7,
          height: getRandom(),
          color: color,
        ),
        SizedBox(
          width: 3,
        ),
        Container(
          width: 7,
          height: getRandom(),
          color: color,
        ),
        SizedBox(
          width: 3,
        ),
        Container(
          width: 7,
          height: getRandom(),
          color: color,
        ),
      ],
    );
  }
}
