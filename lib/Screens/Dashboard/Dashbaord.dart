import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:point_of_sales/Screens/Dashboard/Widgets/AppChartBar.dart';
import 'package:point_of_sales/Screens/Dashboard/Widgets/AppStackedLine.dart';
import 'package:point_of_sales/Screens/Dashboard/Widgets/ColumnChartBar.dart';
import 'package:point_of_sales/Screens/Dashboard/Widgets/InfoTable.dart';
import 'package:point_of_sales/Screens/Dashboard/Widgets/PieChart.dart';
import 'package:point_of_sales/Screens/Dashboard/Widgets/TransactionsHistory.dart';
import 'package:point_of_sales/SharedWidget/AppContainer.dart';
import 'package:point_of_sales/SharedWidget/NumberWidget.dart';
import 'package:point_of_sales/Utils/AppColors.dart';

import 'package:point_of_sales/Utils/Breakpoint.dart';

class Dashbaord extends StatelessWidget {
  const Dashbaord({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          InfoBarWidget(
            data: infoList,
          ),
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
      title: "Users ",
      bgColor: Appcolors.lastBlue,
      barColors: Appcolors.thirdBlue,
      mainIconData: FontAwesomeIcons.person,
      text: "153 user use this app",
      description: "15 new user are added from previous week",
    ),
  ),
  SizedBox(
    child: NumberWidget(
      title: "Products",
      mainIconData: FontAwesomeIcons.boxOpen,
      barColors: Appcolors.mainBlue,
      text: "7530 product are in stock",
      description: "increase by 15 % from previous week",
    ),
  ),
  SizedBox(
    child: NumberWidget(
      title: "Today's sales",
      bgColor: Appcolors.lastBlue,
      mainIconData: FontAwesomeIcons.calendar,
      barColors: Appcolors.thirdBlue,
      text: "153 product",
      description: "Increased by 2% from previous week",
    ),
  ),
  SizedBox(
    child: NumberWidget(
      title: "Total Sales",
      mainIconData: FontAwesomeIcons.dollarSign,
      barColors: Appcolors.mainBlue,
      text: "1530 product are selled",
      description: "total sales for the current week",
    ),
  ),
];

class InfoBarWidget extends StatelessWidget {
  List<Widget> data;
  InfoBarWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return AlignedGridView.custom(
      mainAxisSpacing: 5,
      crossAxisSpacing: 5,
      itemCount: infoList.length,
      itemBuilder: (context, index) {
        return data[index];
      },
      shrinkWrap: true,
      gridDelegate: SliverSimpleGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: width / 4),
    );
  }
}

class InfoBloc2 extends StatelessWidget {
  const InfoBloc2({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (MediaQuery.of(context).size.width > Breakpoint.lg)
          return SizedBox(
              width: double.maxFinite,
              height: 350,
              child: Row(
                children: [
                  Expanded(
                      flex: 1, child: AppContainer(child: AppColumnChartBar())),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(flex: 1, child: AppContainer(child: AppPieChart())),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: AppContainer(
                      height: 450,
                      child: AppStackedLine(),
                    ),
                  )
                ],
              ));
        else
          return Column(
            children: [
              SizedBox(height: 200, child: AppContainer(child: AppChartBar())),
              SizedBox(
                height: 20,
              ),
              SizedBox(height: 300, child: AppContainer(child: AppPieChart())),
              SizedBox(
                height: 20,
              ),
              AppContainer(
                height: 450,
                child: AppStackedLine(),
              ),
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
    return LayoutBuilder(
      builder: (context, constraints) {
        if (MediaQuery.of(context).size.width > Breakpoint.lg)
          return Row(
            children: [
              Expanded(
                  flex: 2,
                  child: AppContainer(
                      child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text("Prodcut Available",
                          style: Theme.of(context).textTheme.titleMedium),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 400,
                        child: DashboardInfoTable(),
                      ),
                    ],
                  ))),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  flex: 1,
                  child: AppContainer(
                      height: 450,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TransactionsHistory(data: []),
                      )))
            ],
          );
        else
          return Column(
            children: [
              SizedBox(
                height: 400,
                child: DashboardInfoTable(),
              ),
              SizedBox(
                height: 20,
              ),
              AppContainer(
                  height: 450,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TransactionsHistory(data: []),
                  ))
            ],
          );
      },
    );
  }
}
