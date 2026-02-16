import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdv/data/entities/order_status.dart';
import 'package:pdv/domain/entities/cart_item.dart';
import 'package:pdv/domain/entities/order.dart';
import 'package:pdv/domain/entities/payment_method.dart';
import 'package:pdv/domain/entities/product.dart';
import 'package:pdv/domain/extensions/int_extensions.dart';
import 'package:pdv/presentation/order/order_page_bloc.dart';
import 'package:pdv/presentation/order/order_page_event.dart';
import 'package:pdv/presentation/order/order_page_state.dart';

void main() {
  group('OrderPageBloc', () {
    late OrderPageBloc bloc;

    setUp(() {
      bloc = OrderPageBloc();
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state should be OrderPageState with empty values', () {
      expect(bloc.state, const OrderPageState());
    });

    group('LoadData', () {
      blocTest<OrderPageBloc, OrderPageState>(
        'emits correct state when order with single item is loaded',
        build: () => bloc,
        act: (bloc) {
          final product = Product(
            id: 1,
            name: 'Test Product',
            priceCents: 1000, // $10.00
          );
          final order = Order.draft();
          final item = CartItem(
            order: order,
            product: product,
            quantity: 2,
            subTotal: 2000,
          );
          final orderWithItems = order.copyWith(items: [item]);

          bloc.add(LoadData(order: orderWithItems));
        },
        expect: () => [
          OrderPageState(
            formattedSubtotalPrice: 2000.formatPrice(), // $20.00
            formattedTaxPrice: 200.formatPrice(), // $2.00 (10% service fee)
            formattedTotalPrice: 2200.formatPrice(), // $22.00
          ),
        ],
      );

      blocTest<OrderPageBloc, OrderPageState>(
        'emits correct state when order with multiple items is loaded',
        build: () => bloc,
        act: (bloc) {
          final product1 = Product(id: 1, name: 'Product 1', priceCents: 1000);
          final product2 = Product(id: 2, name: 'Product 2', priceCents: 1500);
          final order = Order.draft();
          final items = [
            CartItem(
              order: order,
              product: product1,
              quantity: 3,
              subTotal: 3000,
            ),
            CartItem(
              order: order,
              product: product2,
              quantity: 2,
              subTotal: 3000,
            ),
          ];
          final orderWithItems = order.copyWith(items: items);

          bloc.add(LoadData(order: orderWithItems));
        },
        expect: () => [
          OrderPageState(
            formattedSubtotalPrice: 6000.formatPrice(),
            formattedTaxPrice: 600.formatPrice(),
            formattedTotalPrice: 6600.formatPrice(),
          ),
        ],
      );

      test(
        'getOrder returns correctly configured order after LoadData',
        () async {
          final product = Product(
            id: 1,
            name: 'Test Product',
            priceCents: 1000,
          );
          final order = Order.draft();
          final item = CartItem(
            order: order,
            product: product,
            quantity: 2,
            subTotal: 2000,
          );
          final orderWithItems = order.copyWith(items: [item]);

          bloc.add(LoadData(order: orderWithItems));
          await bloc.stream.first;

          final resultOrder = bloc.getOrder();

          expect(resultOrder.totalCents, 2200);
          expect(resultOrder.subTotalCents, 2000);
          expect(resultOrder.serviceFeeCents, 200);
          expect(resultOrder.discountCents, 0);
          expect(resultOrder.status, OrderStatus.draft);
          expect(resultOrder.paymentMethod, PaymentMethod.card);
        },
      );
    });

    group('ToggleDiscount', () {
      setUp(() {
        final product = Product(id: 1, name: 'Test Product', priceCents: 1000);
        final order = Order.draft();
        final item = CartItem(
          order: order,
          product: product,
          quantity: 2,
          subTotal: 2000,
        );
        final orderWithItems = order.copyWith(items: [item]);

        bloc.add(LoadData(order: orderWithItems));
      });

      blocTest<OrderPageBloc, OrderPageState>(
        'applies discount when isToApplyDiscount is true',
        build: () => bloc,
        seed: () => OrderPageState(
          formattedSubtotalPrice: 2000.formatPrice(),
          formattedTaxPrice: 200.formatPrice(),
          formattedTotalPrice: 2200.formatPrice(),
        ),
        act: (bloc) => bloc.add(ToggleDiscount(isToApplyDiscount: true)),
        expect: () => [
          OrderPageState(
            formattedSubtotalPrice: 2000.formatPrice(),
            formattedTaxPrice: 200.formatPrice(),
            formattedTotalPrice: 2090.formatPrice(),
            formattedDiscountPrice: 110.formatPrice(),
            isDiscountApplied: true,
          ),
        ],
      );

      blocTest<OrderPageBloc, OrderPageState>(
        'removes discount when isToApplyDiscount is false',
        build: () => bloc,
        seed: () => OrderPageState(
          formattedSubtotalPrice: 2000.formatPrice(),
          formattedTaxPrice: 200.formatPrice(),
          formattedTotalPrice: 2090.formatPrice(),
          formattedDiscountPrice: 110.formatPrice(),
          isDiscountApplied: true,
        ),
        act: (bloc) => bloc.add(ToggleDiscount(isToApplyDiscount: false)),
        expect: () => [
          OrderPageState(
            formattedSubtotalPrice: 2000.formatPrice(),
            formattedTaxPrice: 200.formatPrice(),
            formattedTotalPrice: 2200.formatPrice(),
            formattedDiscountPrice: "",
            isDiscountApplied: false,
          ),
        ],
      );

      blocTest<OrderPageBloc, OrderPageState>(
        'can toggle discount multiple times',
        build: () => bloc,
        seed: () => OrderPageState(
          formattedSubtotalPrice: 2000.formatPrice(),
          formattedTaxPrice: 200.formatPrice(),
          formattedTotalPrice: 2200.formatPrice(),
        ),
        act: (bloc) {
          bloc.add(ToggleDiscount(isToApplyDiscount: true));
          bloc.add(ToggleDiscount(isToApplyDiscount: false));
          bloc.add(ToggleDiscount(isToApplyDiscount: true));
        },
        expect: () => [
          OrderPageState(
            formattedSubtotalPrice: 2000.formatPrice(),
            formattedTaxPrice: 200.formatPrice(),
            formattedTotalPrice: 2090.formatPrice(),
            formattedDiscountPrice: 110.formatPrice(),
            isDiscountApplied: true,
          ),
          OrderPageState(
            formattedSubtotalPrice: 2000.formatPrice(),
            formattedTaxPrice: 200.formatPrice(),
            formattedTotalPrice: 2200.formatPrice(),
            formattedDiscountPrice: "",
            isDiscountApplied: false,
          ),
          OrderPageState(
            formattedSubtotalPrice: 2000.formatPrice(),
            formattedTaxPrice: 200.formatPrice(),
            formattedTotalPrice: 2090.formatPrice(),
            formattedDiscountPrice: 110.formatPrice(),
            isDiscountApplied: true,
          ),
        ],
      );
    });
  });
}
