import 'package:drift/drift.dart';
import 'package:pdv/data/entities/order_entity.dart';
import 'package:pdv/data/entities/product_entity.dart';

@DataClassName('CartItems')
class CartItemEntity extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get orderId =>
      integer().references(OrderEntity, #id, onDelete: KeyAction.cascade)();
  IntColumn get productId => integer().references(ProductEntity, #id)();
  IntColumn get quantity => integer()();
  IntColumn get subtotal => integer()();
}
