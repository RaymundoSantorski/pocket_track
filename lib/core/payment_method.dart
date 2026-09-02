// enum PaymentMethod { applePay, googlePay, card, cash }

import 'package:isar/isar.dart';
part 'payment_method.g.dart';

enum PaymentType { applePay, googlePay, card, cash }

@collection
class PaymentMethod {
  Id id = Isar.autoIncrement;
  late String name;
  @enumerated
  late PaymentType type;
}
