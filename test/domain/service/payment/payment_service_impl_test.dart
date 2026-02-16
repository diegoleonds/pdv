import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pdv/data/entities/order_status.dart';
import 'package:pdv/domain/entities/cart_item.dart';
import 'package:pdv/domain/entities/order.dart';
import 'package:pdv/domain/entities/payment_method.dart';
import 'package:pdv/domain/entities/product.dart';
import 'package:pdv/domain/service/connectivity/connectivity_service.dart';
import 'package:pdv/domain/service/connectivity/connectivity_status.dart';
import 'package:pdv/domain/service/payment/payment_service_impl.dart';
import 'package:pdv/domain/service/payment/payment_status.dart';
import 'package:pdv/domain/usecase/insert_order_with_cart_items_use_case.dart';

class MockInsertOrderWithCartItemsUseCase extends Mock
    implements InsertOrderWithCartItemsUseCase {}

class MockConnectivityService extends Mock implements ConnectivityService {}

class FakeOrder extends Fake implements Order {}

class MockMethodChannel extends Mock implements MethodChannel {}

void main() {
  group('PaymentService group', () {
    late Product product1;
    late Product product2;
    late Product product3;
    late Order orderDraft;
    late CartItem cartItem1;
    late CartItem cartItem2;
    late CartItem cartItem3;
    late Order orderWithItems;

    late PaymentServiceImpl service;
    late MockInsertOrderWithCartItemsUseCase useCase;
    late MockConnectivityService connectivityService;
    late MockMethodChannel methodChannel;

    setUp(() {
      registerFallbackValue(FakeOrder());

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

      useCase = MockInsertOrderWithCartItemsUseCase();
      connectivityService = MockConnectivityService();
      methodChannel = MockMethodChannel();

      service = PaymentServiceImpl(useCase, connectivityService, methodChannel);
    });

    test(
      'processPayment should return paid order when payment is approved',
      () async {
        when(
          () => connectivityService.checkConnectivity(),
        ).thenAnswer((_) async => ConnectivityStatus.online);

        when(() => methodChannel.invokeMethod(any(), any())).thenAnswer(
          (_) async => {
            "status": PaymentStatus.approved.name.toUpperCase(),
            "authCode": "AUTH123",
          },
        );

        when(() => useCase.call(any())).thenAnswer((_) async => 1);

        final result = await service.processPayment(orderWithItems);

        expect(result.status, OrderStatus.paid);
        expect(result.authCode, "AUTH123");

        verify(() => useCase.call(any())).called(1);
      },
    );

    test(
      'processPayment should return failed order when payment is declined',
      () async {
        when(
          () => connectivityService.checkConnectivity(),
        ).thenAnswer((_) async => ConnectivityStatus.online);

        when(() => methodChannel.invokeMethod(any(), any())).thenAnswer(
          (_) async => {
            "status": PaymentStatus.declined.name.toUpperCase(),
            "authCode": "AUTH456",
          },
        );

        when(() => useCase.call(any())).thenAnswer((_) async => 1);

        final result = await service.processPayment(orderWithItems);

        expect(result.status, OrderStatus.failed);
        expect(result.authCode, "AUTH456");

        verify(() => useCase.call(any())).called(1);
      },
    );

    test(
      'processPayment should return pending order when offline on max attempt',
      () async {
        when(
          () => connectivityService.checkConnectivity(),
        ).thenAnswer((_) async => ConnectivityStatus.offline);
        when(() => useCase.call(any())).thenAnswer((_) async => 42);

        final result = await service.processPayment(orderWithItems);

        expect(result.status, OrderStatus.pending);
        expect(result.authCode, "");
        expect(result.id, 42);

        verify(
          () => connectivityService.checkConnectivity(),
        ).called(service.maxAttempts);
        verifyNever(() => methodChannel.invokeMethod(any(), any()));
        verify(() => useCase.call(any())).called(1);
      },
    );

    test(
      'processPayment should return failed order when payment status is error',
      () async {
        when(
          () => connectivityService.checkConnectivity(),
        ).thenAnswer((_) async => ConnectivityStatus.online);

        when(() => methodChannel.invokeMethod(any(), any())).thenAnswer(
          (_) async => {
            "status": PaymentStatus.error.name.toUpperCase(),
            "authCode": "ERR001",
          },
        );

        when(() => useCase.call(any())).thenAnswer((_) async => 1);

        final result = await service.processPayment(orderWithItems);

        expect(result.status, OrderStatus.failed);
        expect(result.authCode, "ERR001");

        verify(() => useCase.call(any())).called(1);
      },
    );

    test(
      'processPayment should pass correct parameters to method channel',
      () async {
        when(
          () => connectivityService.checkConnectivity(),
        ).thenAnswer((_) async => ConnectivityStatus.online);

        when(() => methodChannel.invokeMethod(any(), any())).thenAnswer(
          (_) async => {
            "status": PaymentStatus.approved.name.toUpperCase(),
            "authCode": "AUTH123",
          },
        );

        when(() => useCase.call(any())).thenAnswer((_) async => 1);

        await service.processPayment(orderWithItems);

        verify(
          () => methodChannel.invokeMethod("requestCardPayment", {
            "orderId": orderWithItems.idempotencyKey,
            "amountCents": orderWithItems.totalCents,
            "forceOutcome": "RANDOM",
            "timeoutMs": "${service.timeout}",
          }),
        ).called(1);
      },
    );

    test(
      'processPayment should handle unknown payment status as error',
      () async {
        when(
          () => connectivityService.checkConnectivity(),
        ).thenAnswer((_) async => ConnectivityStatus.online);
        when(() => methodChannel.invokeMethod(any(), any())).thenAnswer(
          (_) async => {"status": "UNKNOWN_STATUS", "authCode": "UNK001"},
        );
        when(() => useCase.call(any())).thenAnswer((_) async => 1);

        final result = await service.processPayment(orderWithItems);

        expect(result.status, OrderStatus.failed);
        expect(result.authCode, "UNK001");
      },
    );
  });
}