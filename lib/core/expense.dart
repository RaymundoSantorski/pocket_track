import 'package:isar/isar.dart';
import 'package:pocket_track/core/category.dart';
part 'expense.g.dart';

@collection
class Expense {
  Id id = Isar.autoIncrement;
  final bool isExpense;
  final String? description;
  final double amount;
  final DateTime date;
  @enumerated
  final Category category;

  Expense({
    required this.id,
    this.isExpense = true,
    this.description,
    required this.amount,
    required this.date,
    required this.category,
  });
}
