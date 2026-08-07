import 'package:flutter/material.dart';
import 'package:pocket_track/core/database.dart';
import 'package:pocket_track/core/expense.dart';
import 'package:pocket_track/screens/add_expense_screen.dart';
import 'package:provider/provider.dart';

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

  Future<void> confirmDelete(
    BuildContext context,
    Database db,
    Expense expense,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.redAccent),
              SizedBox(width: 10),
              Text('¿Eliminar cliente?'),
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('¿Estás seguro de que deseas eliminar exta transacción?'),
                const SizedBox(height: 10),
                Text(
                  'Esta acción no se puede deshacer y perderás los datos relacionados con el cliente',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
              ),
              child: const Text('Eliminar'),
              onPressed: () async {
                Navigator.of(context).pop();

                await db.delete(expense.id);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      persist: false,
                      duration: Duration(seconds: 3),
                      content: Text('Transacción eliminada'),
                      action: SnackBarAction(
                        label: 'Deshacer',
                        textColor: Colors.white,
                        onPressed: () {
                          db.addExpense(expense);
                        },
                      ),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Database db = context.watch<Database>();

    return Scaffold(
      appBar: AppBar(title: Text('Details')),
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
          // SizedBox(height: 60),
          Expanded(child: SizedBox()),
          Container(
            width: 180,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              border: Border.all(color: Colors.blueAccent, width: 3.0),
            ),
            child: TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddExpenseScreen(expense: widget.expense),
                  ),
                );
              },
              label: Text(
                'Editar',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              icon: Icon(Icons.edit, color: Colors.blueAccent, size: 22),
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: 180,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              color: Colors.redAccent,
            ),
            child: TextButton.icon(
              onPressed: () async {
                await confirmDelete(context, db, widget.expense);
                Navigator.pop(context);
              },
              label: Text(
                'Eliminar',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              icon: Icon(Icons.delete, color: Colors.white, size: 22),
            ),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
