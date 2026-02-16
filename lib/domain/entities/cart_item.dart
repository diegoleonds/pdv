import 'package:equatable/equatable.dart';

import 'order.dart';
import 'product.dart';

class CartItem extends Equatable {
  CartItem({
    this.id,
    required this.order,
    required this.product,
    required this.quantity,
    required this.subTotal,
  });

  final int? id;
  final Product product;
  final Order order;
  int quantity;
  int subTotal;

  CartItem copyWith({
    int? id,
    Product? product,
    Order? order,
    int? quantity,
    int? subTotal,
  }) {
    return CartItem(
      id: id ?? this.id,
      product: product ?? this.product,
      order: order ?? this.order,
      quantity: quantity ?? this.quantity,
      subTotal: subTotal ?? this.subTotal,
    );
  }

  @override
  List<Object?> get props => [id, order, product, quantity, subTotal];
}
