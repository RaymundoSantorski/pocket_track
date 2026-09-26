import 'package:isar/isar.dart';
import 'package:pocket_track/core/expense.dart';

/*
  Estoy muy cansado y no voy a poder concentrarme en una solución
  Comentario escrito para no perder el habito

  TODO: arreglar guardado del metodo de pago y recuperación sincronizada
 */

class ExpenseRepository {
  late Isar isar;
  ExpenseRepository({required this.isar});

  Future<void> save(Expense expense) async {
    await isar.writeTxn(() async {
      await isar.expenses.put(expense);
      await expense.category.save();
      await expense.paymentMethod.save();
    });
  }

  Future<Expense?> get(Id id) async {
    return await isar.expenses.get(id);
  }

  Future<List<Expense>> getAll() async {
    return await isar.expenses.where().findAll();
  }

  Future<void> delete(int id) async {
    await isar.writeTxn(() async {
      isar.expenses.delete(id);
    });
  }
}
