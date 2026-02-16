import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pdv/data/cartitem/cart_item_dao.dart';
import 'package:pdv/data/cartitem/cart_item_repository.dart';
import 'package:pdv/data/cartitem/cart_item_repository_impl.dart';
import 'package:pdv/data/database/app_database.dart';

class FakeCartItemCompanion extends Fake implements CartItemEntityCompanion {}

class MockCartItemDao extends Mock implements CartItemDao {}

void main() {
  group('CartItemRepository test', () {
    setUp(() {
      registerFallbackValue(FakeCartItemCompanion());
    });

    test('insert should call and return dao returned value', () {
      int expectedId = 1;
      MockCartItemDao dao = MockCartItemDao();
      final cartItem = CartItemEntityCompanion(
        productId: Value(1),
        quantity: Value(2),
      );
      CartItemRepository repository = CartItemRepositoryImpl(dao: dao);

      when(() => repository.insert(cartItem)).thenAnswer((_) async => expectedId);

      expect(repository.insert(cartItem), completion(expectedId));
      verify(() => dao.insert(cartItem)).called(1);
    });
  });
}
