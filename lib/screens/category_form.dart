import 'package:flutter/material.dart';
import 'package:pocket_track/core/category.dart';
import 'package:pocket_track/core/category_provider.dart';
import 'package:provider/provider.dart';

class CategoryForm extends StatelessWidget {
  CategoryForm({super.key});

  final TextEditingController categoryNameController = TextEditingController();
  final TextEditingController categoryTypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CategoryProvider db = context.read<CategoryProvider>();
    void saveCategory() {
      if (categoryNameController.text.isEmpty ||
          categoryTypeController.text.isEmpty) {
        return;
      }
      Category newCategory = Category()
        ..name = categoryNameController.text
        ..type = categoryTypeController.text;

      db.save(newCategory);
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Agregar categoria')),
      body: Column(
        children: [
          Card(
            child: TextField(
              controller: categoryNameController,
              decoration: InputDecoration(
                label: Text('Nombre'),
                hint: Text('Familia'),
              ),
              clipBehavior: Clip.none,
            ),
          ),
          Card(
            child: TextField(
              controller: categoryTypeController,
              decoration: InputDecoration(
                label: Text('Tipo'),
                hint: Text('Personal'),
              ),
              clipBehavior: Clip.none,
            ),
          ),
          FilledButton(onPressed: saveCategory, child: Text('Guardar')),
        ],
      ),
    );
  }
}
