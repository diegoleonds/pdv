import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart';
import 'package:pdv/domain/entities/cart_item.dart';
import 'package:pdv/domain/entities/order.dart';
import 'package:pdv/domain/entities/product.dart';
import 'package:pdv/domain/mapper/cart_item_mapper.dart';

void main() {
  group('CartItemMapper', () {
    late Product mockProduct;
    late Order mockOrder;
    late CartItem cartItem;

    setUp(() {
      mockProduct = Product(id: 123, name: 'Test Product', priceCents: 1000);

      mockOrder = Order(id: 456, idempotencyKey: '');

      cartItem = CartItem(
        id: 1,
        order: mockOrder,
        product: mockProduct,
        quantity: 3,
        subTotal: 4500,
      );
    });

    test('toCompanion should map all fields correctly', () {
      const orderId = 789;

      final companion = cartItem.toCompanion(orderId);

      expect(companion.id.present, isFalse);
      expect(companion.orderId.value, orderId);
      expect(companion.productId.value, mockProduct.id);
      expect(companion.quantity.value, cartItem.quantity);
      expect(companion.subtotal.value, cartItem.subTotal);
    });

    test(
      'toCompanion should use provided orderId, not the order.id from CartItem',
      () {
        const differentOrderId = 999;

        final companion = cartItem.toCompanion(differentOrderId);

        expect(companion.orderId.value, differentOrderId);
        expect(companion.orderId.value, isNot(cartItem.order.id));
      },
    );

    test('toCompanion should always set id as absent', () {
      final companion = cartItem.toCompanion(123);

      expect(companion.id.present, isFalse);
      expect(companion.id, isA<Value<int>>());
    });

    test('toCompanion should handle CartItem without id', () {
      final cartItemWithoutId = CartItem(
        order: mockOrder,
        product: mockProduct,
        quantity: 2,
        subTotal: 3000,
      );

      final companion = cartItemWithoutId.toCompanion(555);

      expect(companion.id.present, isFalse);
      expect(companion.orderId.value, 555);
      expect(companion.productId.value, mockProduct.id);
      expect(companion.quantity.value, 2);
      expect(companion.subtotal.value, 3000);
    });

    test('toCompanion should handle zero values correctly', () {
      final cartItemWithZeros = CartItem(
        order: mockOrder,
        product: mockProduct,
        quantity: 0,
        subTotal: 0,
      );

      final companion = cartItemWithZeros.toCompanion(0);

      expect(companion.orderId.value, 0);
      expect(companion.quantity.value, 0);
      expect(companion.subtotal.value, 0);
    });
  });
}