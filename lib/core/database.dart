import 'dart:io';

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pocket_track/core/expense.dart';

class Database extends ChangeNotifier {
  late Isar isar;
  late List<Expense> transactions;
  late List<Expense> incomes;
  late List<Expense> expenses;
  late float balance;
  late float totalIncome;
  late float totalExpense;

  Future<void> initialize() async {
    Directory dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([ExpenseSchema], directory: dir.path);
    await loadExpenses();
  }

  Future<void> addExpense(Expense expense) async {
    await isar.writeTxn(() async {
      await isar.expenses.put(expense);
    });
    loadExpenses();
  }

  Future<void> loadExpenses() async {
    transactions = await isar.expenses.where().findAll();
    expenses = transactions.where((trans) => trans.isExpense == true).toList();
    incomes = transactions.where((trans) => trans.isExpense == false).toList();
    totalExpense = expenses.fold(0, (carry, curr) => carry + curr.amount);
    totalIncome = incomes.fold(0, (carry, curr) => carry + curr.amount);
    notifyListeners();
  }

  Future<void> delete(int id) async {
    await isar.writeTxn(() async {
      isar.expenses.delete(id);
    });
    loadExpenses();
  }
}
