import '../../domain/entities/order.dart';

sealed class PaymentPageEvent {}

class LoadInitialData extends PaymentPageEvent {
  final Order order;

  LoadInitialData({required this.order});
}