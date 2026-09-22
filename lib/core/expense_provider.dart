import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:pocket_track/core/expense.dart';
import 'package:pocket_track/core/expense_repository.dart';

class ExpenseProvider extends ChangeNotifier {
  ExpenseRepository db;
  ExpenseProvider({required this.db}) {
    loadExpenses();
  }
  List<Expense> transactions = [];
  List<Expense> incomes = [];
  List<Expense> expenses = [];
  float balance = 0;
  float totalIncome = 0;
  float totalExpense = 0;

  Future<void> save(Expense expense) async {
    debugPrint('[DB] ${expense.paymentMethod.value?.name}');
    await db.save(expense);
    loadExpenses();
  }

  Future<void> delete(int id) async {
    await db.delete(id);
    loadExpenses();
  }

  Future<void> loadExpenses() async {
    transactions = await db.getAll();
    expenses = transactions.where((trans) => trans.isExpense == true).toList();
    incomes = transactions.where((trans) => trans.isExpense == false).toList();
    totalExpense = expenses.fold(0, (carry, curr) => carry + curr.amount);
    totalIncome = incomes.fold(0, (carry, curr) => carry + curr.amount);
    notifyListeners();
  }
}
