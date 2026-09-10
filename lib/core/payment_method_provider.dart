import 'package:flutter/material.dart';
import 'package:pocket_track/core/payment_method.dart';
import 'package:pocket_track/core/payment_method_repository.dart';

class PaymentMethodProvider extends ChangeNotifier {
  late PaymentMethodRepository db;
  PaymentMethodProvider({required this.db}) {
    load();
  }

  List<PaymentMethod> paymentMethods = [];

  Future<void> load() async {
    paymentMethods = await db.getAll();
    notifyListeners();
  }

  Future<void> save(PaymentMethod paymentMethod) async {
    await db.save(paymentMethod);
    await load();
  }

  Future<void> delete(int id) async {
    await db.delete(id);
    await load();
  }

  Future<PaymentMethod?> get(int id) async {
    return await db.get(id);
  }

  Future<List<PaymentMethod>> getAll() async {
    return await db.getAll();
  }
}
