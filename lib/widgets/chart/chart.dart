import 'package:expense_tracker_app/main.dart';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/models/expense_category.dart';
import 'package:expense_tracker_app/widgets/expenses.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HistChart extends StatelessWidget {
  final double maxTotalExpense;
  final List<Expense> expenseList;
  const HistChart(
      {super.key, required this.maxTotalExpense, required this.expenseList});

  @override
  Widget build(BuildContext context) {
    var foodExpense =
        ExpenseBucket.forCategory(expenseList, ExpenseCategory.FOOD);
    var travelExpense =
        ExpenseBucket.forCategory(expenseList, ExpenseCategory.TRAVEL);
    var leisureExpense =
        ExpenseBucket.forCategory(expenseList, ExpenseCategory.LEISURE);
    var workExpense =
        ExpenseBucket.forCategory(expenseList, ExpenseCategory.WORK);

    print(foodExpense.totalAmountExpended);
    print(travelExpense.totalAmountExpended);
    print(workExpense.totalAmountExpended);
    print(leisureExpense.totalAmountExpended);

    final List<ChartData> chartData = [
      ChartData(x: 'Food', y: foodExpense.totalAmountExpended),
      ChartData(x: 'Leisure', y: leisureExpense.totalAmountExpended),
      ChartData(x: 'Travel', y: travelExpense.totalAmountExpended),
      ChartData(x: 'Work', y: workExpense.totalAmountExpended),
    ];

    return SfCartesianChart(
      plotAreaBackgroundColor: kColorScheme.secondaryContainer,
      primaryXAxis: const CategoryAxis(
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
      primaryYAxis: const NumericAxis(
        isVisible: false,
        minimum: 0,
        interval: 5,
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
