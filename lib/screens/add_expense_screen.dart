import 'package:flutter/material.dart';
import 'package:pocket_track/core/category.dart';
import 'package:pocket_track/core/category_provider.dart';
import 'package:pocket_track/core/expense.dart';
import 'package:pocket_track/core/expense_provider.dart';
import 'package:provider/provider.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key, this.expense});
  final Expense? expense;

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  int? selectedCategoryId;
  Category? selectedCategory;
  bool isExpense = true;

  @override
  void initState() {
    super.initState();
    if (widget.expense != null) {
      _controller.text = '${widget.expense!.amount}';
      _descriptionController.text = widget.expense!.description ?? '';
      selectedCategoryId = widget.expense!.category.value?.id;
      isExpense = widget.expense!.isExpense;
    }
  }

  @override
  Widget build(BuildContext context) {
    ExpenseProvider db = context.read<ExpenseProvider>();
    List<Category> categories = context.watch<CategoryProvider>().categories;
    if (selectedCategory == null && selectedCategoryId != null) {
      for (final category in categories) {
        if (category.id == selectedCategoryId) {
          selectedCategory = category;
          break;
        }
      }
    }
    bool handleAdd() {
      if (_controller.text.isEmpty) return true;
      double value = double.parse(_controller.text);
      String description = _descriptionController.text;
      if (value > 0 && selectedCategory != null) {
        Expense newExpense = widget.expense == null
            ? Expense(
                amount: value,
                isExpense: isExpense,
                date: DateTime.now(),
                description: description,
              )
            : widget.expense!;
        if (widget.expense != null) {
          newExpense
            ..amount = value
            ..isExpense = isExpense
            ..date = DateTime.now()
            ..description = description;
        }
        newExpense.category.value = selectedCategory;
        db.save(newExpense);
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
              categories.isNotEmpty
                  ? DropdownButton<Category>(
                      value: selectedCategory,
                      items: [
                        ...categories.map(
                          (category) => DropdownMenuItem(
                            onTap: () {
                              selectedCategory = category;
                            },
                            value: category,
                            child: Text(category.name),
                          ),
                        ),
                      ],
                      selectedItemBuilder: (context) {
                        return [
                          ...categories.map(
                            (category) => DropdownMenuItem(
                              onTap: () {},
                              value: category,
                              child: Text(category.name),
                            ),
                          ),
                        ];
                      },
                      onChanged: (Category? value) {
                        setState(() {
                          selectedCategory = value;
                        });
                      },
                    )
                  : SizedBox.shrink(),
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
