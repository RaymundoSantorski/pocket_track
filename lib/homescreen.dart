import 'package:flutter/material.dart';
import 'package:pocket_track/core/database.dart';
import 'package:pocket_track/core/expense.dart';
import 'package:pocket_track/screens/add_expense_screen.dart';
import 'package:pocket_track/widgets/expense_list.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool? isExpense;

  @override
  Widget build(BuildContext context) {
    List<Expense> transactions = context.watch<Database>().transactions;
    List<Expense> expenses = context.watch<Database>().expenses;
    List<Expense> incomes = context.watch<Database>().incomes;
    double totalIncome = context.watch<Database>().totalIncome;
    double totalExpense = context.watch<Database>().totalExpense;

    ColorScheme theme = Theme.of(context).colorScheme;

    void setItemsToShow(bool? value) {
      setState(() {
        isExpense = value;
      });
    }

    return Scaffold(
      backgroundColor: theme.surface,
      appBar: AppBar(
        backgroundColor: theme.primary,
        title: Text(
          widget.title,
          style: TextStyle(
            color: theme.onPrimary,
            fontWeight: FontWeight.w600,
            fontFamily: "Inter",
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddExpenseScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: transactions.isEmpty
            ? Container()
            : expenseList(
                setItemsToShow: setItemsToShow,
                isExpense: isExpense,
                totalIncome: totalIncome,
                totalExpense: totalExpense,
                transactions: transactions,
                expenses: expenses,
                incomes: incomes,
                date: DateTime.now(),
              ),
      ),
    );
  }
}
