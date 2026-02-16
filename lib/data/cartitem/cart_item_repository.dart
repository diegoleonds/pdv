import '../database/app_database.dart';

abstract class CartItemRepository {
  Future<int> insert(CartItemEntityCompanion cartItem);
}
