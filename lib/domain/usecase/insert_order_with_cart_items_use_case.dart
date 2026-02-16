import 'package:pdv/data/cartitem/cart_item_repository.dart';
import 'package:pdv/data/order/order_repository.dart';
import 'package:pdv/domain/mapper/cart_item_mapper.dart';
import 'package:pdv/domain/mapper/order_mapper.dart';
import '../entities/cart_item.dart';
import '../entities/order.dart';

class InsertOrderWithCartItemsUseCase {
  final OrderRepository _orderRepository;
  final CartItemRepository _cartItemRepository;

  InsertOrderWithCartItemsUseCase(
    this._orderRepository,
    this._cartItemRepository,
  );

  Future<int> call(Order order) async {
    List<CartItem> items = order.items;
    if (items.isEmpty) {
      throw Exception('Cannot create order without items');
    }
    final orderId = await _orderRepository.insert(order.toCompanion());
    for (final item in items) {
      await _cartItemRepository.insert(item.toCompanion(orderId));
    }

    return orderId;
  }
}
