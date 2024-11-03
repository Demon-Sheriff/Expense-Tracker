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
          secondaryBackground: Container(
            alignment: Alignment.centerRight,
            color: Theme.of(context).colorScheme.error.withOpacity(0.75),
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: const Align(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  Text(
                    "Delete",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
          ),
          background: Container(
            color: Colors.green,
          ),
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
                barrierDismissible: false,
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
