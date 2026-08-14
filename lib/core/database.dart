import 'dart:io';

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pocket_track/core/category.dart';
import 'package:pocket_track/core/expense.dart';

class Database extends ChangeNotifier {
  late Isar isar;

  Future<void> initialize() async {
    Directory dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([
      ExpenseSchema,
      CategorySchema,
    ], directory: dir.path);
  }
}
