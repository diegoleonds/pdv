import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pdv/data/database/app_database.dart';
import 'package:pdv/data/products/product_dao.dart';
import 'package:pdv/data/products/product_repository_impl.dart';
import 'package:pdv/domain/entities/product.dart';

class MockProductDao extends Mock implements ProductDao {}

class FakeProductEntityCompanion extends Fake
    implements ProductEntityCompanion {}

void main() {
  late ProductRepositoryImpl repository;
  late MockProductDao mockDao;

  setUpAll(() {
    registerFallbackValue(FakeProductEntityCompanion());
  });

  setUp(() {
    mockDao = MockProductDao();
    repository = ProductRepositoryImpl(mockDao);
  });

  group('ProductRepository test', () {
    test('getProducts should return a list of products from dao', () async {
      final expectedProducts = [
        Products(id: 1, name: 'Product 1', priceCents: 1000),
        Products(id: 2, name: 'Product 2', priceCents: 2000),
      ];

      when(
        () => mockDao.getProducts(),
      ).thenAnswer((_) async => expectedProducts);

      final result = await repository.getProducts();

      expect(result, equals(expectedProducts));
      verify(() => mockDao.getProducts()).called(1);
    });

    test(
      'insertProducts should call dao insert for each product in the list',
      () async {
        final products = [
          Product(id: 1, name: 'A', priceCents: 100),
          Product(id: 2, name: 'B', priceCents: 200),
        ];

        when(() => mockDao.insert(any())).thenAnswer((_) async => 1);

        await repository.insertProducts(products);

        verify(() => mockDao.insert(any())).called(products.length);
      },
    );
  });
}
