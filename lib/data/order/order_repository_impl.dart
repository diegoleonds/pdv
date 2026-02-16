import 'package:drift/drift.dart';
import 'package:pdv/data/database/app_database.dart';
import 'package:pdv/data/order/order_repository.dart';
import '../entities/order_status.dart';
import 'order_dao.dart';

class OrderRepositoryImpl implements OrderRepository {

  final OrderDao dao;

  OrderRepositoryImpl({required this.dao});

  @override
  Future<int> insert(OrderEntityCompanion order) async =>
      await dao.insert(order);

  @override
  Future<Map<OrderStatus, int>> getOrderCountByStatus() async =>
      dao.getOrderCountByStatus();
}
