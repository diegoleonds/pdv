import 'package:flutter_test/flutter_test.dart';
import 'package:pdv/data/database/app_database.dart';
import 'package:pdv/domain/mapper/product_mapper.dart';

void main() {
  group('ProductsMapper', () {
    test('should map all fields correctly from Products to Product', () {
      const products = Products(
        id: 123,
        name: 'Test Product',
        priceCents: 1999,
      );

      final product = products.toDomain();

      expect(product.id, equals(123));
      expect(product.name, equals('Test Product'));
      expect(product.priceCents, equals(1999));
    });
  });
}
