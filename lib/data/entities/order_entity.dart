import 'package:drift/drift.dart';
import 'package:pdv/data/entities/order_status.dart';
import 'package:pdv/domain/entities/payment_method.dart';

@DataClassName('Orders')
class OrderEntity extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get idempotencyKey => text().unique()();
  IntColumn get totalCents => integer()();
  IntColumn get subTotalCents => integer()();
  IntColumn get discountCents => integer()();
  IntColumn get serviceFeeCents => integer()();
  IntColumn get status => intEnum<OrderStatus>()();
  IntColumn get paymentMethod => intEnum<PaymentMethod>()();
  TextColumn get authCode => text()();
}