import 'package:expense_tracker_app/models/expense_category.dart';
import 'package:expense_tracker_app/widgets/expense_list/expense_item.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});
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
        if (enteredAmount == null ||
            enteredAmount < 0 ||
            _titleController.text.trim().isEmpty ||
            _selectedDate == null) {
          return;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
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
              const SizedBox(width: 16),
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
    );
  }
}
