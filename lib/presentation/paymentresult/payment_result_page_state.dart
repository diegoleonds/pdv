import 'package:equatable/equatable.dart';
import 'package:pdv/data/entities/order_status.dart';

class PaymentResultPageState extends Equatable {
  final String title;
  final String message;
  final OrderStatus status;

  const PaymentResultPageState({
    this.title = "",
    this.message = "",
    this.status = OrderStatus.draft,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [title, message, status];
}
