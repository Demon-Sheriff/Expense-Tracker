import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/models/expense_category.dart';
import 'package:expense_tracker_app/widgets/expense_list/expense_item.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  final void Function(Expense expense) addExpenseFunction;
  const NewExpense({super.key, required this.addExpenseFunction});

  @override
  State<NewExpense> createState() {
    return _NewExpense();
  }
}

class _NewExpense extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  ExpenseCategory _selectedCategory = ExpenseCategory.LEISURE;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _showDateCalendar() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 10, now.month, now.day);
    // waiting for the input from the user. -> needs to be an async opertaion.
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _saveExpense() {
    setState(
      () {
        final enteredAmount = double.tryParse(_amountController.text);
        final enteredTtitle = _titleController.text.trim().toString();
        if (enteredAmount == null ||
            enteredAmount <= 0 || // entered amount limit atleast positive.
            _titleController.text.trim().isEmpty ||
            _selectedDate == null) {
          showDialog(
            context: context,
            builder: (BuildContext ctx) {
              return AlertDialog(
                title: const Text('Invalid Input'),
                content:
                    const Text('Please enter a valid amount, title, and date.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text('Close'),
                  ),
                ],
              );
            },
          );
          return;
        } else {
          // Add the expense to you expense list.
          Expense newExpense = Expense(
              title: enteredTtitle,
              amount: enteredAmount,
              date: _selectedDate!,
              category: _selectedCategory);
          print(
              'Adding a new expense with ${_titleController.text.toString()}');
          widget.addExpenseFunction(newExpense);
          Navigator.pop(context);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final keyBoardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final maxWidth = constraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              16,
              16,
              16,
              keyBoardSpace + 10,
            ),
            child: Column(
              children: [
                if (maxWidth >= 600)
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 21,
                          ),
                          child: TextField(
                            controller: _titleController,
                            maxLength: 50,
                            decoration: const InputDecoration(
                              label: Text(
                                'Title',
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefix: Text(
                              '\$',
                            ),
                            label: Text(
                              'Amount',
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    controller: _titleController,
                    maxLength: 50,
                    decoration: const InputDecoration(
                      label: Text(
                        'Title',
                      ),
                    ),
                  ),
                Row(
                  children: [
                    if (maxWidth < 600)
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefix: Text(
                              '\$',
                            ),
                            label: Text(
                              'Amount',
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(
                      width: 16,
                    ),
                    if (maxWidth >= 600)
                      DropdownButton(
                        value: _selectedCategory,
                        items: ExpenseCategory.values.map(
                          (category) {
                            return DropdownMenuItem(
                              value: category,
                              child: Text(
                                category.name,
                              ),
                            );
                          },
                        ).toList(),
                        onChanged: (value) {
                          if (value == null) return;
                          setState(
                            () {
                              _selectedCategory = value;
                            },
                          );
                        },
                      ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            (_selectedDate == null)
                                ? ('No date selected')
                                : (formatter.format(_selectedDate!)),
                          ),
                          IconButton(
                            onPressed: _showDateCalendar,
                            icon: const Icon(Icons.calendar_month),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  // row of save and cancel buttons.
                  children: [
                    if (maxWidth < 600)
                      DropdownButton(
                        value: _selectedCategory,
                        items: ExpenseCategory.values.map(
                          (category) {
                            return DropdownMenuItem(
                              value: category,
                              child: Text(
                                category.name,
                              ),
                            );
                          },
                        ).toList(),
                        onChanged: (value) {
                          if (value == null) return;
                          setState(
                            () {
                              _selectedCategory = value;
                            },
                          );
                        },
                      ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        _saveExpense();
                      },
                      child: const Text('Save Expense'),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
