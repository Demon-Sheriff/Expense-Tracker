import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/models/expense_category.dart';
import 'package:expense_tracker_app/widgets/expense_list/expense_list.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _Expenses();
  }
}

class _Expenses extends State<Expenses> {
  final List<Expense> _expenseList = [
    Expense(
      title: 'Flutter Course',
      amount: 500.56,
      date: DateTime.now(),
      category: ExpenseCategory.WORK,
    ),
    Expense(
      title: 'Cold Coffee',
      amount: 5,
      date: DateTime.now(),
      category: ExpenseCategory.FOOD,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Expense'),
        actions: [],
      ),
      body: Column(
        children: [
          const Text(
            'Chart will be here',
          ),
          // Expanded(child: ExpenseList(expenseList: expenseList)),
          Expanded(
            child: ExpenseList(
              expenseList: _expenseList,
            ),
          )
        ],
      ),
    );
  }
}
