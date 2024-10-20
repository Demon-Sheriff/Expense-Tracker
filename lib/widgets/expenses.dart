import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/models/expense_category.dart';
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
  void _openModalOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext ctx) {
        return const NewExpense();
      },
    );
  }

  final List<Expense> expenseList = [
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
        title: const Text('Add Expense'),
        actions: [
          IconButton(
            onPressed: () {
              _openModalOverlay();
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          const Text(
            'Chart will be here',
          ),
          // Expanded(child: ExpenseList(expenseList: expenseList)),
          Expanded(
            child: ExpenseList(
              expenseList: expenseList,
            ),
          )
        ],
      ),
    );
  }
}
