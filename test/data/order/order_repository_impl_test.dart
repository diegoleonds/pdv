import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:drift/drift.dart';
import 'package:pdv/data/database/app_database.dart';
import 'package:pdv/data/entities/order_status.dart';
import 'package:pdv/data/order/order_dao.dart';
import 'package:pdv/data/order/order_repository_impl.dart';

class MockOrderDao extends Mock implements OrderDao {}
class FakeOrderEntityCompanion extends Fake implements OrderEntityCompanion {}

void main() {
  group('OrderRepository test', () {
    late OrderRepositoryImpl repository;
    late MockOrderDao mockDao;

    setUpAll(() {
      registerFallbackValue(FakeOrderEntityCompanion());
    });

    setUp(() {
      mockDao = MockOrderDao();
      repository = OrderRepositoryImpl(dao: mockDao);
    });

    test('insert call dao and return its generated value', () async {
      const expectedId = 10;
      const order = OrderEntityCompanion(
        totalCents: Value(150),
        status: Value(OrderStatus.pending),
      );
      when(() => mockDao.insert(any())).thenAnswer((_) async => expectedId);

      final result = await repository.insert(order);

      expect(result, expectedId);
      verify(() => mockDao.insert(order)).called(1);
    });

    test('getOrderCountByStatus should return expected map', () async {
      final expectedMap = {
        OrderStatus.pending: 5,
        OrderStatus.paid: 12,
      };
      when(() => mockDao.getOrderCountByStatus()).thenAnswer((_) async => expectedMap);

      final result = await repository.getOrderCountByStatus();

      expect(result, isA<Map<OrderStatus, int>>());
      expect(result[OrderStatus.pending], 5);
      expect(result, equals(expectedMap));
      verify(() => mockDao.getOrderCountByStatus()).called(1);
    });
  });
}