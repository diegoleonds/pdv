import 'package:flutter_test/flutter_test.dart';
import 'package:pdv/data/entities/order_status.dart';
import 'package:pdv/domain/entities/cart_item.dart';
import 'package:pdv/domain/entities/order.dart';
import 'package:pdv/domain/entities/payment_method.dart';
import 'package:pdv/domain/entities/product.dart';
import 'package:drift/drift.dart';
import 'package:pdv/domain/mapper/order_mapper.dart';

void main() {
  group('OrderMapper', () {
    late Product product1;
    late Product product2;
    late Order order;
    late CartItem cartItem1;
    late CartItem cartItem2;

    setUp(() {
      product1 = Product(
        id: 1,
        name: 'Produto A',
        priceCents: 1000,
      );

      product2 = Product(
        id: 2,
        name: 'Produto B',
        priceCents: 2500,
      );

      order = Order(
        id: 123,
        idempotencyKey: 'order-uuid-12345',
        totalCents: 5000,
        subTotalCents: 4500,
        serviceFeeCents: 500,
        discountCents: 0,
        paymentMethod: PaymentMethod.card,
        authCode: 'AUTH123456',
        status: OrderStatus.paid,
        items: [],
      );

      cartItem1 = CartItem(
        order: order,
        product: product1,
        quantity: 2,
        subTotal: 2000,
      );

      cartItem2 = CartItem(
        order: order,
        product: product2,
        quantity: 1,
        subTotal: 2500,
      );
    });

    group('toCompanion', () {
      test('should map all fields correctly', () {
        final companion = order.toCompanion();

        expect(companion.id.present, isFalse);
        expect(companion.idempotencyKey.value, 'order-uuid-12345');
        expect(companion.totalCents.value, 5000);
        expect(companion.subTotalCents.value, 4500);
        expect(companion.serviceFeeCents.value, 500);
        expect(companion.discountCents.value, 0);
        expect(companion.paymentMethod.value, PaymentMethod.card);
        expect(companion.authCode.value, 'AUTH123456');
        expect(companion.status.value, OrderStatus.paid);
      });

      test('should set id as absent for database auto-generation', () {
        final companion = order.toCompanion();

        expect(companion.id.present, isFalse);
        expect(companion.id, isA<Value<int>>());
      });

      test('should handle null authCode by setting empty string', () {
        final orderWithoutAuth = order.copyWith(authCode: null);

        final companion = orderWithoutAuth.toCompanion();

        expect(companion.authCode.value, order.authCode);
        expect(companion.authCode.value, isNot(null));
      });

      test('should handle zero discount correctly', () {
        final companion = order.toCompanion();

        expect(companion.discountCents.value, 0);
      });

    });

    group('toReceiptMap', () {
      test('should generate receipt with header and all items', () {
        final orderWithItems = order.copyWith(items: [cartItem1, cartItem2]);

        final receipt = orderWithItems.toReceiptMap();

        expect(receipt['orderId'], 'order-uuid-12345');

        final lines = receipt['lines'] as List<String>;
        expect(lines[0], 'Mini POS - Recibo');
        expect(lines[1], contains('Produto A x2'));
        expect(lines[2], contains('Produto B x1'));
      });

      test('should format prices correctly in receipt lines', () {
        final orderWithItems = order.copyWith(items: [cartItem1]);

        final receipt = orderWithItems.toReceiptMap();
        final lines = receipt['lines'] as List<String>;

        expect(lines[1], 'Produto A x2 20,00');

        expect(lines, contains('Subtotal: R\$\u00A045,00'));
        expect(lines, contains('Taxa: R\$\u00A05,00'));
        expect(lines, contains('Total: R\$\u00A050,00'));
      });

      test('should include payment method in receipt', () {
        final receipt = order.toReceiptMap();
        final lines = receipt['lines'] as List<String>;

        expect(lines, contains('Pagamento: Cartão'));
      });

      test('should include auth code when present', () {
        final receipt = order.toReceiptMap();
        final lines = receipt['lines'] as List<String>;

        expect(lines, contains('Auth: AUTH123456'));
      });

      test('should not include auth code line when authCode is null', () {
        final orderWithoutAuth = order.copyWith(authCode: '');

        final receipt = orderWithoutAuth.toReceiptMap();
        final lines = receipt['lines'] as List<String>;

        expect(lines, isNot(contains(startsWith('Auth:'))));
        expect(lines.where((line) => line.startsWith('Auth:')), isEmpty);
      });

      test('should handle empty items list', () {
        final orderNoItems = order.copyWith(items: []);

        final receipt = orderNoItems.toReceiptMap();
        final lines = receipt['lines'] as List<String>;

        expect(lines[0], 'Mini POS - Recibo');
        expect(lines, contains('Subtotal: R\$\u00A045,00'));
        expect(lines.length, greaterThan(1)); // Should have header + summary
      });

      test('should return map with correct structure', () {
        final receipt = order.toReceiptMap();

        expect(receipt, isA<Map<String, Object>>());
        expect(receipt.keys, containsAll(['orderId', 'lines']));
        expect(receipt['orderId'], isA<String>());
        expect(receipt['lines'], isA<List<String>>());
      });

      test('should generate complete receipt with multiple items', () {
        final orderWithItems = order.copyWith(
          items: [cartItem1, cartItem2],
          totalCents: 5000,
          subTotalCents: 4500,
          serviceFeeCents: 500,
        );

        final receipt = orderWithItems.toReceiptMap();
        final lines = receipt['lines'] as List<String>;

        expect(
          lines.length,
          8,
        );
        expect(lines[0], 'Mini POS - Recibo');
        expect(lines[1], 'Produto A x2 20,00');
        expect(lines[2], 'Produto B x1 25,00');
        expect(lines[3], 'Subtotal: R\$\u00A045,00');
        expect(lines[4], 'Taxa: R\$\u00A05,00');
        expect(lines[5], 'Total: R\$\u00A050,00');
        expect(lines[6], 'Pagamento: Cartão');
        expect(lines[7], 'Auth: ${orderWithItems.authCode}');
      });

      test('should handle large quantities and amounts', () {
        final expensiveProduct = Product(
          id: 3,
          name: 'Produto Caro',
          priceCents: 99900,
        );

        final expensiveItem = CartItem(
          order: order,
          product: expensiveProduct,
          quantity: 10,
          subTotal: 999000,
        );

        final expensiveOrder = order.copyWith(
          items: [expensiveItem],
          totalCents: 999000,
          subTotalCents: 999000,
        );

        final receipt = expensiveOrder.toReceiptMap();
        final lines = receipt['lines'] as List<String>;

        expect(lines[1], 'Produto Caro x10 9.990,00');
        expect(lines, contains('Total: R\$\u00A09.990,00'));
      });
    });
  });
}
