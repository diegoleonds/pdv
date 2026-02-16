import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pdv/data/database/app_database.dart';
import 'package:pdv/data/products/product_repository.dart';
import 'package:pdv/domain/entities/cart_item.dart';
import 'package:pdv/domain/entities/order.dart';
import 'package:pdv/domain/entities/product.dart';
import 'package:pdv/domain/mapper/product_mapper.dart';
import 'package:pdv/presentation/products/product_list_bloc.dart';
import 'package:pdv/presentation/products/product_list_event.dart';
import 'package:pdv/presentation/products/product_list_state.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  group('ProductListBloc', () {
    late ProductListBloc bloc;
    late MockProductRepository mockRepository;

    final order = Order.draft();
    final product1 = Products(id: 1, name: "Product 1", priceCents: 1000);
    final product2 = Products(id: 2, name: "Product 2", priceCents: 2000);
    final product3 = Products(id: 3, name: "Product 3", priceCents: 3000);

    final cartItem1 = CartItem(
      order: order,
      product: product1.toDomain(),
      quantity: 0,
      subTotal: product1.priceCents,
    );

    final cartItem2 = CartItem(
      order: order,
      product: product2.toDomain(),
      quantity: 0,
      subTotal: product2.priceCents * 2,
    );

    final cartItem3 = CartItem(
      order: order,
      product: product3.toDomain(),
      quantity: 0,
      subTotal: product3.priceCents * 3,
    );

    final products = [product1, product2, product3];
    final items = [cartItem1, cartItem2, cartItem3];

    setUp(() {
      mockRepository = MockProductRepository();
      bloc = ProductListBloc(mockRepository);
    });

    tearDown(() {
      bloc.close();
    });

    blocTest<ProductListBloc, ProductListState>(
      'should emit isLoading true and then false with items when LoadProducts is added',
      build: () {
        when(
          () => mockRepository.getProducts(),
        ).thenAnswer((_) async => products);
        return bloc;
      },
      act: (bloc) => bloc.add(LoadProducts()),
      expect: () => [
        isA<ProductListState>().having((s) => s.isLoading, 'isLoading', true),
        isA<ProductListState>()
            .having((s) => s.isLoading, 'isLoading', false)
            .having((s) => s.items.length, 'items count', products.length),
      ],
    );

    blocTest<ProductListBloc, ProductListState>(
      'should enable button and set quantity to 1 when AddProductToCart is added',
      seed: () => ProductListState(items: items),
      build: () => bloc,
      act: (bloc) => bloc.add(AddProductToCart(cartItem1)),
      expect: () => [
        isA<ProductListState>()
            .having((s) => s.isButtonEnabled, 'isButtonEnabled', true)
            .having((s) => s.items.first.quantity, 'quantity', 1)
            .having(
              (s) => s.items.first.subTotal,
              'subTotal',
              cartItem1.product.priceCents,
            ),
      ],
    );

    blocTest<ProductListBloc, ProductListState>(
      'should increment quantity and subtotal when IncreaseProductQuantity is added',
      seed: () => ProductListState(items: [cartItem1.copyWith(quantity: 1)]),
      build: () => bloc,
      act: (bloc) =>
          bloc.add(IncreaseProductQuantity(cartItem1.copyWith(quantity: 1))),
      expect: () => [
        isA<ProductListState>()
            .having((s) => s.items.first.quantity, 'quantity', 2)
            .having(
              (s) => s.items.first.subTotal,
              'subTotal',
              cartItem1.subTotal * 2,
            ),
      ],
    );

    blocTest<ProductListBloc, ProductListState>(
      'should decrement quantity and update isButtonEnabled when DecreaseProductQuantity is added',
      seed: () => ProductListState(
        items: [cartItem1.copyWith(quantity: 1, subTotal: 100)],
        isButtonEnabled: true,
      ),
      build: () => bloc,
      act: (bloc) =>
          bloc.add(DecreaseProductQuantity(cartItem1.copyWith(quantity: 1))),
      expect: () => [
        isA<ProductListState>()
            .having((s) => s.items.first.quantity, 'quantity', 0)
            .having((s) => s.isButtonEnabled, 'isButtonEnabled', false)
            .having((s) => s.items.first.subTotal, 'subTotal', 0),
      ],
    );

    blocTest<ProductListBloc, ProductListState>(
      'should reset quantity to 0 and disable button when DeleteProduct is added',
      seed: () => ProductListState(
        items: [cartItem1.copyWith(quantity: 5, subTotal: 500)],
        isButtonEnabled: true,
      ),
      build: () => bloc,
      act: (bloc) => bloc.add(DeleteProduct(cartItem1)),
      expect: () => [
        isA<ProductListState>()
            .having((s) => s.items.first.quantity, 'quantity', 0)
            .having((s) => s.items.first.subTotal, 'subTotal', 0)
            .having((s) => s.isButtonEnabled, 'isButtonEnabled', false),
      ],
    );
  });
}
