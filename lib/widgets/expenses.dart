import 'dart:math';

import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/models/expense_category.dart';
import 'package:expense_tracker_app/widgets/app_theme.dart';
import 'package:expense_tracker_app/widgets/chart/chart.dart';
import 'package:expense_tracker_app/widgets/expense_list/expense_list.dart';
import 'package:expense_tracker_app/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _Expenses();
  }
}

class _Expenses extends State<Expenses> {
  double maxTotalExpense() {
    var foodExpense =
        ExpenseBucket.forCategory(expenseList, ExpenseCategory.FOOD);
    var travelExpense =
        ExpenseBucket.forCategory(expenseList, ExpenseCategory.FOOD);
    var leisureExpense =
        ExpenseBucket.forCategory(expenseList, ExpenseCategory.FOOD);
    var workExpense =
        ExpenseBucket.forCategory(expenseList, ExpenseCategory.WORK);

    double maxExpense = max(
        workExpense.totalAmountExpended,
        max(
            leisureExpense.totalAmountExpended,
            max(foodExpense.totalAmountExpended,
                travelExpense.totalAmountExpended)));
    return maxExpense;
  }

  void addExpense(Expense expense) {
    setState(() {
      expenseList.add(expense);
    });
  }

  void _openModalOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return NewExpense(addExpenseFunction: addExpense);
      },
    );
  }

  List<Expense> expenseList = [
    // Expense(
    //   title: 'Flutter Course',
    //   amount: 500.56,
    //   date: DateTime.now(),
    //   category: ExpenseCategory.WORK,
    // ),
    // Expense(
    //   title: 'Cold Coffee',
    //   amount: 50,
    //   date: DateTime.now(),
    //   category: ExpenseCategory.FOOD,
    // )
  ];

  @override
  Widget build(BuildContext context) {
    var maxExpense = maxTotalExpense();

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    print("I am reached");
    print("${height} ${width}");

    Widget bodyContent = (expenseList.isEmpty)
        ? const Center(child: Text('No Expenses Added Yet.'))
        : ExpenseList(
            onRemoveItem: (index) {
              Expense expenseToRemove = expenseList[index];
              setState(() {
                expenseList.removeAt(index);
              });
              // clear the previous snack bars if the widget re-renders.
              ScaffoldMessenger.of(context).clearSnackBars();
              // show a new snack bar for 5 seconds for undoing the delete operation.
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(
                    seconds: 4,
                  ),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      setState(
                        () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          expenseList.insert(index, expenseToRemove);
                          // Navigator.of(ctx)
                        },
                      );
                    },
                  ),
                  content: Text(
                    '${expenseToRemove.title} Deleted',
                  ),
                  // // Alternate way using Row
                  // content: Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     IconButton(
                  //       onPressed: () {
                  //         setState(() {
                  //           ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  //           expenseList.insert(index, expenseToRemove);
                  //           // Navigator.of(ctx)
                  //         });
                  //       },
                  //       icon: const Icon(
                  //         Icons.undo,
                  //       ),
                  //     ),
                  //     const Text(
                  //       'Undo',
                  //     ),
                  //   ],
                  // ),
                ),
              );
            },
            expenseList: expenseList,
          );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Expense',
          style: TextStyle(),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _openModalOverlay();
            },
            icon: const Icon(Icons.add),
          ),
          // dark/light/system's mode button
          const AppTheme(),
        ],
      ),
      body: (width < 600)
          ? Column(
              children: [
                // To complete (Chart.)
                HistChart(
                  maxTotalExpense: maxExpense,
                  expenseList: expenseList,
                ),
                // Expanded(child: ExpenseList(expenseList: expenseList)),
                Expanded(
                  child: bodyContent,
                )
              ],
            )
          : Row(
              children: [
                HistChart(
                  maxTotalExpense: maxExpense,
                  expenseList: expenseList,
                ),
                // Expanded(child: ExpenseList(expenseList: expenseList)),
                Expanded(
                  child: bodyContent,
                )
              ],
            ),
    );
  }
}

class ExpenseBucket {
  final ExpenseCategory expenseCategory;
  final List<Expense> expenseList;

  const ExpenseBucket(
      {required this.expenseCategory, required this.expenseList});
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.expenseCategory)
      : expenseList = allExpenses
            .where((expense) => expense.category == expenseCategory)
            .toList();

  double get totalAmountExpended {
    double sum = 0;
    for (Expense expense in expenseList) {
      sum += expense.amount;
    }
    return sum;
  }
}
