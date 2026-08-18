import 'package:flutter/material.dart';
import 'package:pocket_track/core/category.dart';
import 'package:pocket_track/core/category_provider.dart';
import 'package:pocket_track/screens/category_form.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    List<Category> categories = context.watch<CategoryProvider>().categories;
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => CategoryForm()));
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          ...categories.map((category) {
            return Text(category.name);
          }),
        ],
      ),
    );
  }
}
