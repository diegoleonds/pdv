import 'package:pdv/data/cartitem/cart_item_repository.dart';
import 'package:pdv/data/database/app_database.dart';

import 'cart_item_dao.dart';

class CartItemRepositoryImpl implements CartItemRepository {
  final CartItemDao dao;

  CartItemRepositoryImpl({required this.dao});

  @override
  Future<int> insert(CartItemEntityCompanion cartItem) => dao.insert(cartItem);
}
