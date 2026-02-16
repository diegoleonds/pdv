import 'package:equatable/equatable.dart';

import '../../domain/entities/cart_item.dart';

sealed class ProductListEvent extends Equatable {}

class AddProductToCart extends ProductListEvent {
  final CartItem cartItem;

  AddProductToCart(this.cartItem);

  @override
  List<Object?> get props => [cartItem];
}

class IncreaseProductQuantity extends ProductListEvent {
  final CartItem cartItem;

  IncreaseProductQuantity(this.cartItem);

  @override
  List<Object?> get props => [cartItem];
}

class DecreaseProductQuantity extends ProductListEvent {
  final CartItem cartItem;

  DecreaseProductQuantity(this.cartItem);

  @override
  List<Object?> get props => [cartItem];
}

class DeleteProduct extends ProductListEvent {
  final CartItem cartItem;

  DeleteProduct(this.cartItem);

  @override
  List<Object?> get props => [cartItem];
}

class LoadProducts extends ProductListEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}