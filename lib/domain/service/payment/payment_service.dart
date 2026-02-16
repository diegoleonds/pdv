import '../../entities/order.dart';

abstract class PaymentService {
  Future<Order> processPayment(Order order);
}
