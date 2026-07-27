import 'package:flutter/material.dart';
import 'package:pocket_track/core/category.dart';

List<DropdownMenuItem<Category>> categoryItems() {
  List<DropdownMenuItem<Category>> categories = [];
  for (Category category in Category.values) {
    categories.add(
      DropdownMenuItem(
        onTap: () {},
        value: category,
        child: Text(category.name),
      ),
    );
  }
  return categories;
}
