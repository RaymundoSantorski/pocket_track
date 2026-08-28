import 'package:flutter/material.dart';
import 'package:pocket_track/core/expense.dart';
import 'package:pocket_track/core/expense_provider.dart';
import 'package:pocket_track/screens/add_expense_screen.dart';
import 'package:pocket_track/screens/categories_screen.dart';
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
    List<Expense> transactions = context.watch<ExpenseProvider>().transactions;
    List<Expense> expenses = context.watch<ExpenseProvider>().expenses;
    List<Expense> incomes = context.watch<ExpenseProvider>().incomes;
    double totalIncome = context.watch<ExpenseProvider>().totalIncome;
    double totalExpense = context.watch<ExpenseProvider>().totalExpense;

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
        actions: [
          IconButton(
            icon: const Icon(Icons.navigate_next),
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => CategoriesScreen()));
            },
          ),
        ],
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
                context: context,
              ),
      ),
    );
  }
}
