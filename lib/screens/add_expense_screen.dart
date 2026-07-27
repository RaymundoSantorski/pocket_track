import 'package:flutter/material.dart';
import 'package:pocket_track/core/category.dart';
import 'package:pocket_track/core/database.dart';
import 'package:pocket_track/core/expense.dart';
import 'package:pocket_track/screens/category_items.dart';
import 'package:provider/provider.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  Category? selectedCategory = Category.business;
  bool isExpense = true;

  @override
  Widget build(BuildContext context) {
    Database db = context.read<Database>();
    bool handleAdd() {
      if (_controller.text.isEmpty) return true;
      double value = double.parse(_controller.text);
      String description = _descriptionController.text;
      if (value > 0 && selectedCategory != null) {
        db.addExpense(
          Expense(
            amount: value,
            category: selectedCategory!,
            isExpense: isExpense,
            date: DateTime.now(),
            id: DateTime.now().millisecondsSinceEpoch,
            description: description,
          ),
        );
      }
      return true;
    }

    return PopScope(
      canPop: false, // Evita que el usuario salga inmediatamente
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        // Ejecuta tu lógica al hacer pop
        bool salir = handleAdd();

        if (salir) {
          Navigator.pop(
            context,
          ); // Cierra la pantalla manualmente si el usuario aceptó
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Add Expense')),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ChoiceChip(
                    label: Text('Expense'),
                    selected: isExpense,
                    onSelected: (_) {
                      setState(() {
                        isExpense = true;
                      });
                    },
                  ),
                  ChoiceChip(
                    label: Text('Income'),
                    selected: !isExpense,
                    onSelected: (_) {
                      setState(() {
                        isExpense = false;
                      });
                    },
                  ),
                ],
              ),
              TextField(
                controller: _controller,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onChanged: (value) => {_controller.text = value},
                decoration: InputDecoration(
                  label: Text('Amount'),
                  hint: Text('50.0'),
                  prefix: Text('\$'),
                ),
              ),
              TextField(
                controller: _descriptionController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  label: Text('Description'),
                  hint: Text('Clothes shopping'),
                ),
              ),
              DropdownButton<Category>(
                value: selectedCategory,
                items: categoryItems(),
                selectedItemBuilder: (context) {
                  return categoryItems();
                },
                onChanged: (Category? value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
              ),
              TextButton(
                child: Text('Guardar'),
                onPressed: () {
                  handleAdd();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
