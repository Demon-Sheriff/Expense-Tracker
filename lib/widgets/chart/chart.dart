import 'package:expense_tracker_app/main.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HistChart extends StatelessWidget {
  const HistChart({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData(x: 'Food', y: 39),
      ChartData(x: 'Leisure', y: 38),
      ChartData(x: 'Travel', y: 90),
      ChartData(x: 'Work', y: 89),
    ];

    return SfCartesianChart(
      // plotAreaBackgroundColor: kColorScheme.primary,
      primaryXAxis: const CategoryAxis(),
      primaryYAxis: const NumericAxis(
        isVisible: false,
        minimum: 0,
        maximum: 100,
        interval: 10,
      ),
      series: <CartesianSeries<ChartData, String>>[
        ColumnSeries<ChartData, String>(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(
              5,
            ),
            topRight: Radius.circular(
              5,
            ),
          ),
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          color: kColorScheme.onPrimaryContainer,
        ),
      ],
    );
  }
}

class ChartData {
  double y;
  String x;

  ChartData({required this.x, required this.y});
}
