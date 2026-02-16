import 'package:equatable/equatable.dart';

import '../../domain/entities/order.dart';

sealed class PaymentResultEvent extends Equatable {}

class LoadData extends PaymentResultEvent {
  final Order order;

  LoadData({required this.order});

  @override
  // TODO: implement props
  List<Object?> get props => [order];
}