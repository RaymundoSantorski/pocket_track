import 'package:flutter/material.dart';
import 'package:pocket_track/core/category.dart';
import 'package:pocket_track/core/category_provider.dart';
import 'package:provider/provider.dart';

class CategoryForm extends StatefulWidget {
  const CategoryForm({super.key, this.category});
  final Category? category;

  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final TextEditingController categoryNameController = TextEditingController();

  final TextEditingController categoryTypeController = TextEditingController();

  @override
  void initState() {
    if (widget.category != null) {
      if (mounted) {
        setState(() {
          categoryNameController.text = widget.category!.name;
          categoryTypeController.text = widget.category!.type;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    CategoryProvider db = context.read<CategoryProvider>();
    void saveCategory() {
      if (categoryNameController.text.isEmpty ||
          categoryTypeController.text.isEmpty) {
        return;
      }
      if (widget.category != null) {
        widget.category!.name = categoryNameController.text;
        widget.category!.type = categoryTypeController.text;
        db.save(widget.category!);
      } else {
        Category newCategory = Category()
          ..name = categoryNameController.text
          ..type = categoryTypeController.text;

        db.save(newCategory);
      }
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
