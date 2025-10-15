import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AppStackedLine extends StatelessWidget {
  const AppStackedLine({super.key});

  @override
  Widget build(BuildContext context) {
    final List<SalesData> chartData = [
      SalesData("Mon", 135),
      SalesData("Tue", 128),
      SalesData("Wed", 34),
      SalesData("Thur", 32),
      SalesData("Fri", 40),
      SalesData("sat", 40),
      SalesData("Sun", 40)
    ];

    return Center(
        child: Container(
            child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                title: ChartTitle(
                    alignment: ChartAlignment.center,
                    text: "Sales Revenu Current Week",
                    textStyle: Theme.of(context).textTheme.titleSmall),
                series: <CartesianSeries>[
          // Renders line chart
          LineSeries<SalesData, String>(
              dataSource: chartData,
              xValueMapper: (SalesData sales, _) => sales.day,
              yValueMapper: (SalesData sales, _) => sales.sales)
        ])));
  }
}

class SalesData {
  SalesData(this.day, this.sales);
  final String day;
  final double sales;
}
