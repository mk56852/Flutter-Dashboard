import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AppColumnChartBar extends StatefulWidget {
  AppColumnChartBar({Key? key}) : super(key: key);

  @override
  AppColumnChartBarState createState() => AppColumnChartBarState();
}

class AppColumnChartBarState extends State<AppColumnChartBar> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    data = [
      _ChartData('Mon', 12),
      _ChartData('Tue', 15),
      _ChartData('Wed', 30),
      _ChartData('Thu', 6.4),
      _ChartData('Fri', 14),
      _ChartData('Sat', 18),
      _ChartData('Sun', 24)
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        title: ChartTitle(
            alignment: ChartAlignment.center,
            text: "Sales per day",
            textStyle: Theme.of(context).textTheme.titleSmall),
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(minimum: 0, maximum: 40, interval: 10),
        tooltipBehavior: _tooltip,
        series: <CartesianSeries<_ChartData, String>>[
          ColumnSeries<_ChartData, String>(
              dataSource: data,
              xValueMapper: (_ChartData data, _) => data.x,
              yValueMapper: (_ChartData data, _) => data.y,
              name: 'Gold',
              color: Color.fromRGBO(8, 142, 255, 1))
        ]);
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
