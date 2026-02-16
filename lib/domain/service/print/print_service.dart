import '../../entities/order.dart';

abstract class PrintService {
  Future print(Order order);
}