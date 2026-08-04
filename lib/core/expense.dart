import 'package:isar/isar.dart';
import 'package:pocket_track/core/category.dart';
part 'expense.g.dart';

@collection
class Expense {
  Id id = Isar.autoIncrement;
  bool isExpense;
  String? description;
  double amount;
  DateTime date;
  @enumerated
  Category category;

  Expense({
    this.isExpense = true,
    this.description,
    required this.amount,
    required this.date,
    required this.category,
  });
}
