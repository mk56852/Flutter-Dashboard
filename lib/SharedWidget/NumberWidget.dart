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
      this.fontColor});

  @override
  Widget build(BuildContext context) {
    Color bg = bgColor ?? Colors.white;
    Color ft = fontColor ?? Colors.black;
    Color iconC = iconColor ?? Colors.white;
    Color IconBg = iconBgColor ?? Appcolors.thirdBlue;
    Color IconBorder = iconBorderColor ?? Colors.white;
    return AppContainer(
      elevation: 1,
      width: AppDimension.numberWidgetMinWidth,
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
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 17, color: ft),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      text,
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                )),
                NumberWidgetIconContainer(
                  iconColor: iconC,
                  bgColor: IconBg,
                  borderColor: IconBorder,
                  iconData: mainIconData,
                  size: 45,
                ),
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

class NumberWidgetIconContainer extends StatelessWidget {
  IconData iconData;
  double size;
  Color bgColor;
  Color iconColor;
  Color borderColor;
  NumberWidgetIconContainer(
      {super.key,
      required this.iconData,
      required this.size,
      required this.bgColor,
      required this.iconColor,
      required this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor),
          color: bgColor),
      child: Icon(
        iconData,
        color: iconColor,
        size: 20,
      ),
    );
  }
}
