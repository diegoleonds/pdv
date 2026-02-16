import 'package:drift/drift.dart';

import '../database/app_database.dart';
import '../entities/order_entity.dart';
import '../entities/order_status.dart';

@DriftAccessor(tables: [OrderEntity])
class OrderDao extends DatabaseAccessor<AppDatabase> {
  OrderDao(super.db);

  Future<int> insert(OrderEntityCompanion order) async =>
      await into(db.orderEntity).insert(order);

  Future<Map<OrderStatus, int>> getOrderCountByStatus() async =>
      queryOrderCountByStatus();

  Future<Map<OrderStatus, int>> queryOrderCountByStatus() async {
    final query = selectOnly(db.orderEntity)
      ..addColumns([db.orderEntity.status, db.orderEntity.id.count()])
      ..groupBy([db.orderEntity.status]);

    final results = await query.get();

    return {
      for (final row in results)
        OrderStatus.values[row.read(db.orderEntity.status)!]: row.read(
          db.orderEntity.id.count(),
        )!,
    };
  }
}
