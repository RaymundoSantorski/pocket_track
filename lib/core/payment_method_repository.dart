import 'package:isar/isar.dart';
import 'package:pocket_track/core/payment_method.dart';

class PaymentMethodRepository {
  late Isar isar;
  PaymentMethodRepository({required this.isar});

  Future<void> save(PaymentMethod paymentMethod) async {
    await isar.writeTxn(() async {
      await isar.paymentMethods.put(paymentMethod);
    });
  }

  Future<void> delete(Id id) async {
    await isar.writeTxn(() async {
      await isar.paymentMethods.delete(id);
    });
  }

  Future<PaymentMethod?> get(Id id) async {
    return await isar.paymentMethods.get(id);
  }

  Future<List<PaymentMethod>> getAll() async {
    return await isar.paymentMethods.where().findAll();
  }
}
