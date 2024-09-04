import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:point_of_sales/Screens/Dashboard/Dashbaord.dart';
import 'package:point_of_sales/Screens/Financial/widgets/AppLineBar2.dart';
import 'package:point_of_sales/SharedWidget/AppContainer.dart';
import 'package:point_of_sales/SharedWidget/NumberWidget.dart';
import 'package:point_of_sales/Utils/AppColors.dart';
import 'package:point_of_sales/Utils/AppDimension.dart';

class FinancialScreen extends StatelessWidget {
  const FinancialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          InfoBarWidget(data: infoList),
          AppContainer(
            height: 500,
            width: 500,
            child: AppLineBar2(),
          )
        ],
      ),
    );
  }
}

List<Widget> infoList = [
  SizedBox(
    child: NumberWidget(
      title: "Users number",
      bgColor: Appcolors.lastBlue,
      mainIconData: FontAwesomeIcons.person,
      text: "153",
      description: "15 new user are added",
    ),
  ),
  SizedBox(
    child: NumberWidget(
      title: "Products",
      bgColor: Appcolors.mainGreen,
      iconColor: Colors.black,
      fontColor: Colors.white,
      iconBgColor: Colors.white,
      iconBorderColor: Colors.white,
      mainIconData: FontAwesomeIcons.boxOpen,
      text: "7530 product",
      description: "increase by 15 %",
    ),
  ),
  SizedBox(
    child: NumberWidget(
      title: "Today's sales",
      mainIconData: FontAwesomeIcons.calendar,
      text: "153 product",
      description: "Increased by 2%",
    ),
  ),
  SizedBox(
    child: NumberWidget(
      title: "total Sales",
      mainIconData: FontAwesomeIcons.dollarSign,
      text: "1530 product",
      description: "increased by 19%",
    ),
  )
];
