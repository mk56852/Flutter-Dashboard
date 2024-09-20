import 'package:flutter/material.dart';
import 'package:point_of_sales/Utils/AppColors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AppPieChart extends StatefulWidget {
  AppPieChart({Key? key}) : super(key: key);

  @override
  AppPieChartState createState() => AppPieChartState();
}

class AppPieChartState extends State<AppPieChart> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    data = [
      _ChartData('In stock', 38, Appcolors.thirdBlue),
      _ChartData('Out of stock', 10, Colors.redAccent),
      _ChartData('Low stock', 22, Appcolors.secondBlue),
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
        tooltipBehavior: _tooltip,
        title: ChartTitle(
            alignment: ChartAlignment.center,
            text: "Product Status",
            textStyle: Theme.of(context).textTheme.titleSmall),
        legend: Legend(isVisible: true, position: LegendPosition.bottom),
        series: <CircularSeries<_ChartData, String>>[
          DoughnutSeries<_ChartData, String>(
              dataLabelMapper: (_ChartData data, _) {
                if (data.y == 0)
                  return "";
                else
                  return data.y.toString() + "\n product";
              },
              dataLabelSettings: const DataLabelSettings(isVisible: true),
              dataSource: data,
              xValueMapper: (_ChartData data, _) => data.x,
              yValueMapper: (_ChartData data, _) => data.y,
              pointColorMapper: (_ChartData data, _) => data.color,
              name: 'Gold')
        ]);
  }
}

class _ChartData {
  _ChartData(this.x, this.y, this.color);

  final String x;
  final double y;
  final Color color;
}
