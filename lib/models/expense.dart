import 'package:uuid/uuid.dart';
import 'expense_category.dart';

var uuid = const Uuid();

class Expense {
  final String id; // random id attached to
  final String
      title; // we can store strings efficiently by creating hashes of each string.
  final double amount;
  final DateTime date;
  final ExpenseCategory category;

  Expense({required this.title, required this.amount, required this.date, required this.category})
      : id = uuid.v4();
}
