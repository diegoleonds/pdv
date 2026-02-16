import 'package:equatable/equatable.dart';
import 'package:pdv/domain/entities/cart_item.dart';
import 'package:pdv/domain/entities/product.dart';

class ProductListState {
  final List<CartItem> items;
  final bool isLoading;
  final bool isButtonEnabled;
  final bool isShoppingCartCreated;

  const ProductListState({
    this.isLoading = false,
    this.items = const [],
    this.isButtonEnabled = false,
    this.isShoppingCartCreated = false,
  });

  ProductListState copyWith({
    List<Product>? products,
    List<CartItem>? items,
    bool? isLoading,
    bool? isButtonEnabled,
    bool? isShoppingCartCreated,
  }) => ProductListState(
    items: items ?? this.items,
    isLoading: isLoading ?? this.isLoading,
    isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
    isShoppingCartCreated: isShoppingCartCreated ?? this.isShoppingCartCreated,
  );
}
