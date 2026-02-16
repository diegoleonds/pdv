import 'package:drift/drift.dart';
import 'package:pdv/data/database/app_database.dart';

import '../entities/cart_item_entity.dart';

@DriftAccessor(tables: [CartItemEntity])
class CartItemDao extends DatabaseAccessor<AppDatabase> {
  CartItemDao(super.db);

  Future<int> insert(CartItemEntityCompanion cartItem) {
    return into(db.cartItemEntity).insert(cartItem);
  }
}