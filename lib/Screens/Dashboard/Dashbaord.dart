import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:point_of_sales/Screens/Dashboard/Widgets/AppChartBar.dart';
import 'package:point_of_sales/Screens/Dashboard/Widgets/AppLineChart.dart';
import 'package:point_of_sales/Screens/Dashboard/Widgets/AppPieChart.dart';
import 'package:point_of_sales/SharedWidget/AppContainer.dart';
import 'package:point_of_sales/SharedWidget/NumberWidget.dart';
import 'package:point_of_sales/Utils/AppDimension.dart';
import 'package:point_of_sales/Utils/AppTable.dart';
import 'package:point_of_sales/Utils/Breakpoint.dart';

class Dashbaord extends StatelessWidget {
  const Dashbaord({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          InfoBarWidget(),
          SizedBox(
            height: 20,
          ),
          InfoBloc2(),
          SizedBox(
            height: 20,
          ),
          InfoBloc3()
        ],
      ),
    );
  }
}

List<Widget> infoList = [
  SizedBox(
    child: NumberWidget(
      title: "Users number",
      mainIconData: FontAwesomeIcons.person,
      text: "153",
      description: "15 new user are added",
    ),
  ),
  SizedBox(
    child: NumberWidget(
      title: "Products",
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

class InfoBarWidget extends StatelessWidget {
  InfoBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlignedGridView.custom(
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      itemCount: infoList.length,
      itemBuilder: (context, index) {
        return infoList[index];
      },
      shrinkWrap: true,
      gridDelegate: SliverSimpleGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: AppDimension.numberWidgetMinWidth + 40),
    );
  }
}

class InfoBloc2 extends StatelessWidget {
  const InfoBloc2({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (MediaQuery.of(context).size.width > Breakpoint.md)
          return SizedBox(
              width: double.maxFinite,
              height: 450,
              child: Row(
                children: [
                  Expanded(flex: 7, child: AppContainer(child: AppChartBar())),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(flex: 5, child: AppContainer(child: AppPieChart()))
                ],
              ));
        else
          return Column(
            children: [
              SizedBox(height: 200, child: AppContainer(child: AppChartBar())),
              SizedBox(
                height: 20,
              ),
              SizedBox(height: 300, child: AppContainer(child: AppPieChart()))
            ],
          );
      },
    );
  }
}

class InfoBloc3 extends StatelessWidget {
  const InfoBloc3({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: AppContainer(child: AppLineChart())),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
