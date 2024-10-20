import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/models/expense_category.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const categoryIcons = {
  ExpenseCategory.FOOD: Icons.lunch_dining,
  ExpenseCategory.LEISURE: Icons.movie,
  ExpenseCategory.TRAVEL: Icons.flight_takeoff,
  ExpenseCategory.WORK: Icons.work,
};

final formatter = DateFormat.yMd();

// --------------------------------------------------------------------------------------------------------------- //

class ExpenseItem extends StatelessWidget {
  final Expense expense;
  const ExpenseItem({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Card(
      // padding: const EdgeInsets.all(10),
      color: const Color.fromARGB(255, 221, 142, 230),
      margin: const EdgeInsets.all(10),
      // decoration: const BoxDecoration(
      //   color: Color.fromARGB(220, 217, 177, 252),
      //   borderRadius: BorderRadius.all(
      //     Radius.circular(10),
      //   ),
      //   // border: Border.all(
      //   //   color: Colors.blueAccent,
      //   // ),
      // ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  expense.title,
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  "\$${expense.amount.toStringAsFixed(2)}",
                ),
                const Spacer(), // takes all the space it can get between the up and below widgets
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(formatter.format(expense.date))
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
