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

  NumberWidget({
    super.key,
    required this.title,
    required this.mainIconData,
    required this.text,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimension.numberWidgetMinWidth,
      child: AppContainer(
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
                      style: TextStyle(fontWeight: FontWeight.bold),
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
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                      description!,
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      style: TextStyle(fontSize: 13),
                    ),
                  )
                ],
              )
          ],
        ),
      )),
    );
  }
}

class NumberWidgetIconContainer extends StatelessWidget {
  IconData iconData;
  double size;
  NumberWidgetIconContainer(
      {super.key, required this.iconData, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Appcolors.containerColor),
          color: Appcolors.thirdBlue),
      child: Icon(
        iconData,
        color: Colors.white,
        size: 20,
      ),
    );
  }
}
