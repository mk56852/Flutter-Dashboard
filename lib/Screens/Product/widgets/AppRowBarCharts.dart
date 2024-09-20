import 'package:flutter/material.dart';
import 'package:point_of_sales/Utils/AppColors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AppRowBarChart extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  AppRowBarChart({Key? key}) : super(key: key);

  @override
  AppRowBarChartState createState() => AppRowBarChartState();
}

class AppRowBarChartState extends State<AppRowBarChart> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    data = [
      _ChartData('CHN', 12),
      _ChartData('GER', 15),
      _ChartData('RUS', 30),
      _ChartData('BRZ', 6.4),
      _ChartData('IND', 14)
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        title: ChartTitle(
            alignment: ChartAlignment.center,
            text: "Stock By Category",
            textStyle: Theme.of(context).textTheme.titleSmall),
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(minimum: 0, maximum: 40, interval: 10),
        tooltipBehavior: _tooltip,
        series: <CartesianSeries<_ChartData, String>>[
          BarSeries<_ChartData, String>(
              dataSource: data,
              xValueMapper: (_ChartData data, _) => data.x,
              yValueMapper: (_ChartData data, _) => data.y,
              name: 'Gold',
              color: Appcolors.thirdBlue)
        ]);
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
