import 'package:drift/drift.dart';
import 'package:pdv/data/database/app_database.dart';
import 'package:pdv/domain/entities/cart_item.dart';

extension CartItemMapper on CartItem {
  CartItemEntityCompanion toCompanion(int orderId) => CartItemEntityCompanion(
    id: Value.absent(),
    orderId: Value(orderId),
    productId: Value(product.id),
    quantity: Value(quantity),
    subtotal: Value(subTotal),
  );
}
