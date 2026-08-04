import 'package:flutter/material.dart';
import 'package:pocket_track/core/expense.dart';
import 'package:pocket_track/screens/add_expense_screen.dart';

class ExpenseDetailsScreen extends StatefulWidget {
  final Expense expense;
  const ExpenseDetailsScreen({super.key, required this.expense});

  @override
  State<ExpenseDetailsScreen> createState() => _ExpenseDetailsScreenState();
}

class _ExpenseDetailsScreenState extends State<ExpenseDetailsScreen> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController typeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    amountController.text = widget.expense.amount.toString();
    descriptionController.text = widget.expense.description?.toString() ?? '';
    categoryController.text = widget.expense.category.name;
    typeController.text = widget.expense.isExpense ? 'Gasto' : 'Ingreso';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddExpenseScreen(expense: widget.expense),
                ),
              );
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: Column(
        children: [
          TextField(
            controller: amountController,
            decoration: InputDecoration(label: Text('Monto')),
            enabled: false,
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(label: Text('Descripción')),
            enabled: false,
          ),
          TextField(
            controller: categoryController,
            decoration: InputDecoration(label: Text('Categoria')),
            enabled: false,
          ),
          TextField(
            controller: typeController,
            decoration: InputDecoration(label: Text('Tipo')),
            enabled: false,
          ),
        ],
      ),
    );
  }
}
