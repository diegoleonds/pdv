import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pdv/data/cartitem/cart_item_repository.dart';
import 'package:pdv/data/database/app_database.dart';
import 'package:pdv/data/entities/order_status.dart';
import 'package:pdv/data/order/order_repository.dart';
import 'package:pdv/domain/entities/cart_item.dart';
import 'package:pdv/domain/entities/order.dart';
import 'package:pdv/domain/entities/payment_method.dart';
import 'package:pdv/domain/entities/product.dart';
import 'package:pdv/domain/usecase/insert_order_with_cart_items_use_case.dart';

class OrderRepositoryMock extends Mock implements OrderRepository {}
class CartItemRepositoryMock extends Mock implements CartItemRepository {}

class FakeOrderEntityCompanion extends Fake implements OrderEntityCompanion {}
class FakeCartItemCompanion extends Fake implements CartItemEntityCompanion {}

void main() {
  group('InsertOrderWithCartItemsUseCase', () {
    late OrderRepositoryMock mockOrderRepository;
    late CartItemRepositoryMock mockCartItemRepository;
    late InsertOrderWithCartItemsUseCase useCase;

    late Product product1;
    late Product product2;
    late Product product3;
    late Order orderDraft;
    late CartItem cartItem1;
    late CartItem cartItem2;
    late CartItem cartItem3;
    late Order orderWithItems;

    setUp(() {
      registerFallbackValue(FakeOrderEntityCompanion());
      registerFallbackValue(FakeCartItemCompanion());

      mockOrderRepository = OrderRepositoryMock();
      mockCartItemRepository = CartItemRepositoryMock();
      useCase = InsertOrderWithCartItemsUseCase(
        mockOrderRepository,
        mockCartItemRepository,
      );

      product1 = Product(id: 1, name: 'Espresso', priceCents: 450);
      product2 = Product(id: 2, name: 'Cappuccino', priceCents: 650);
      product3 = Product(id: 3, name: 'Croissant', priceCents: 800);

      orderDraft = Order(
        id: null,
        idempotencyKey: 'test-order-001',
        totalCents: 4450,
        subTotalCents: 3950,
        discountCents: 0,
        serviceFeeCents: 500,
        status: OrderStatus.draft,
        paymentMethod: PaymentMethod.card,
        items: [],
        authCode: null,
      );

      cartItem1 = CartItem(
        id: null,
        order: orderDraft,
        product: product1,
        quantity: 2,
        subTotal: 900,
      );

      cartItem2 = CartItem(
        id: null,
        order: orderDraft,
        product: product2,
        quantity: 1,
        subTotal: 650,
      );

      cartItem3 = CartItem(
        id: null,
        order: orderDraft,
        product: product3,
        quantity: 3,
        subTotal: 2400,
      );

      orderWithItems = orderDraft.copyWith(
        items: [cartItem1, cartItem2, cartItem3],
      );
    });

    test('call should return inserted order id when everything runs', () async {
      final id = 1;
      when(() => mockOrderRepository.insert(any())).thenAnswer((_) async => id);
      when(() => mockCartItemRepository.insert(any())).thenAnswer((_) async => 2);

      final int returnedId = await useCase.call(orderWithItems);

      expect(returnedId, id);
    });

    test('call should throw exception when order has no items', () async {
      expect(() => useCase.call(orderDraft), throwsA(isA<Exception>()));
    });


    test('call should call insert for each order item', () async {
      final id = 1;
      when(() => mockOrderRepository.insert(any())).thenAnswer((_) async => id);
      when(() => mockCartItemRepository.insert(any())).thenAnswer((_) async => 2);

      await useCase.call(orderWithItems);

      verify(() => mockCartItemRepository.insert(any())).called(orderWithItems.items.length);
    });
  });
}