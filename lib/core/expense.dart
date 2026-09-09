import 'package:isar/isar.dart';
import 'package:pocket_track/core/category.dart';
import 'package:pocket_track/core/payment_method.dart';
part 'expense.g.dart';

@collection
class Expense {
  Id id = Isar.autoIncrement;
  bool isExpense;
  String? description;
  double amount;
  DateTime date;

  final category = IsarLink<Category>();
  final paymentMethod = IsarLink<PaymentMethod>();

  Expense({
    this.isExpense = true,
    this.description,
    required this.amount,
    required this.date,
  });
}
// 