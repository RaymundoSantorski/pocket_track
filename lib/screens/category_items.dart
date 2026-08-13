import 'package:flutter/material.dart';
import 'package:pocket_track/core/category.dart';

List<DropdownMenuItem<Categories>> categoryItems() {
  List<DropdownMenuItem<Categories>> categories = [];
  for (Categories category in Categories.values) {
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
