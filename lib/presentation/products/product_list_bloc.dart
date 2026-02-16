import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdv/data/products/product_repository.dart';
import 'package:pdv/domain/entities/cart_item.dart';
import 'package:pdv/domain/mapper/product_mapper.dart';
import 'package:pdv/presentation/products/product_list_event.dart';
import 'package:pdv/presentation/products/product_list_state.dart';

import '../../domain/entities/order.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final ProductRepository _productRepository;

  late Order _order;
  late List<CartItem> items;

  ProductListBloc(this._productRepository) : super(const ProductListState()) {
    on<LoadProducts>(_onLoadProducts);
    on<AddProductToCart>(_onAddProductToCart);
    on<IncreaseProductQuantity>(_onIncreaseProductQuantity);
    on<DecreaseProductQuantity>(_onDecreaseProductQuantity);
    on<DeleteProduct>(_onDeleteProduct);
  }

  void _onAddProductToCart(
    AddProductToCart event,
    Emitter<ProductListState> emitter,
  ) async {
    final items = state.items;
    final index = items.indexWhere(
      (p) => p.product.id == event.cartItem.product.id,
    );

    items[index] = event.cartItem.copyWith(
      quantity: 1,
      subTotal: event.cartItem.product.priceCents,
    );

    emitter.call(state.copyWith(items: items, isButtonEnabled: true));
  }

  void _onIncreaseProductQuantity(
    IncreaseProductQuantity event,
    Emitter<ProductListState> emitter,
  ) async {
    final items = state.items;
    final index = items.indexWhere(
      (p) => p.product.id == event.cartItem.product.id,
    );

    final int newQuantity = event.cartItem.quantity + 1;

    items[index] = event.cartItem.copyWith(
      quantity: newQuantity,
      subTotal: newQuantity * event.cartItem.product.priceCents,
    );

    emitter.call(state.copyWith(items: items));
  }

  void _onDecreaseProductQuantity(
    DecreaseProductQuantity event,
    Emitter<ProductListState> emitter,
  ) async {
    final items = state.items;
    final index = items.indexWhere(
      (p) => p.product.id == event.cartItem.product.id,
    );

    final int newQuantity = event.cartItem.quantity - 1;

    items[index] = event.cartItem.copyWith(
      quantity: newQuantity,
      subTotal: newQuantity * event.cartItem.product.priceCents,
    );

    emitter.call(
      state.copyWith(
        items: items,
        isButtonEnabled: state.items.any((item) => item.quantity > 0),
      ),
    );
  }

  void _onDeleteProduct(
    DeleteProduct event,
    Emitter<ProductListState> emitter,
  ) async {
    final items = state.items;
    final index = items.indexWhere(
      (p) => p.product.id == event.cartItem.product.id,
    );

    items[index] = event.cartItem.copyWith(quantity: 0, subTotal: 0);

    emitter.call(
      state.copyWith(
        items: items,
        isButtonEnabled: state.items.any((item) => item.quantity > 0),
      ),
    );
  }

  void _onLoadProducts(
    LoadProducts event,
    Emitter<ProductListState> emitter,
  ) async {
    emitter.call(ProductListState(isLoading: true));
    _order = Order.draft();

    final products = (await _productRepository.getProducts())
        .map((product) => product.toDomain())
        .toList();

    items = products.map((product) {
      return CartItem(
        product: product,
        order: _order,
        quantity: 0,
        subTotal: 0,
      );
    }).toList();

    emitter.call(ProductListState(items: items, isLoading: false));
  }

  Order getOrder() {
    _order = _order.copyWith(items: getSelectedItems());
    return _order;
  }

  List<CartItem> getSelectedItems() =>
      state.items.where((item) => item.quantity > 0).toList();
}
