import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/widgets/expense_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expenseList;
  final Function(int) onRemoveItem;
  const ExpenseList(
      {super.key, required this.expenseList, required this.onRemoveItem});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenseList.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: ValueKey(expenseList[index]),
          // onDismissed: (direction) {
          //   // print('hi');
          //   print(expenseList.length);
          //   onRemoveItem(index);
          // },
          confirmDismiss: (direction) async {
            // if the user swipes to the left.
            if (direction == DismissDirection.endToStart) {
              final bool confirmationToDelete = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text(
                        'Are you sure you want to delete expense ${expenseList[index].title} ?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          onRemoveItem(index);
                          Navigator.of(context).pop(true);
                        },
                        child: const Text(
                          'Delete',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
              // print(confirmationToDelete);
              return confirmationToDelete;
            }
            return null;
          },
          // for click effect.
          child: InkWell(
            onTap: () {},
            child: ExpenseItem(
              expense: expenseList[index],
            ),
          ),
        );
      },
    );
  }
}
