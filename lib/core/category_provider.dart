import 'package:flutter/material.dart';
import 'package:pocket_track/core/category.dart';
import 'package:pocket_track/core/category_repository.dart';

class CategoryProvider extends ChangeNotifier {
  CategoryRepository db;
  CategoryProvider({required this.db}) {
    load();
  }

  List<Category> categories = [];

  Future<void> load() async {
    categories = await db.getAll();
  }

  Future<void> save(Category category) async {
    await db.save(category);
    load();
  }

  Future<void> delete(int id) async {
    await db.delete(id);
    load();
  }
}
