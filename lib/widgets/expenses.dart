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
  void addExpense(Expense expense) {
    setState(() {
      expenseList.add(expense);
    });
  }

  void _openModalOverlay() {
    showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return NewExpense(addExpenseFunction: addExpense);
      },
    );
  }

  List<Expense> expenseList = [
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
    Widget bodyContent = (expenseList.isEmpty)
        ? const Center(child: Text('No Expenses Added Yet.'))
        : ExpenseList(
            onRemoveItem: (index) {
              setState(
                () {
                  expenseList.removeAt(index);
                },
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
        backgroundColor: const Color.fromARGB(255, 66, 57, 182),
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
          // To complete (Chart.)
          const Text(
            'Chart will be here',
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
