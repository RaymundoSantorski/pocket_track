import 'package:isar/isar.dart';
import 'package:pocket_track/core/category.dart';

class CategoryRepository {
  late Isar isar;
  CategoryRepository({required this.isar});

  Future<void> save(Category category) async {
    await isar.writeTxn(() async {
      await isar.categorys.put(category);
    });
  }

  Future<void> delete(Id id) async {
    await isar.writeTxn(() async {
      await isar.categorys.delete(id);
    });
  }

  Future<List<Category>> getAll() async {
    return await isar.categorys.where().findAll();
  }

  Future<Category?> get(Id id) async {
    return await isar.categorys.get(id);
  }
}
