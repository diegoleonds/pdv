import '../database/app_database.dart';
import '../entities/order_status.dart';

abstract class OrderRepository {
  Future<int> insert(OrderEntityCompanion order);
  Future<Map<OrderStatus, int>> getOrderCountByStatus();
}
