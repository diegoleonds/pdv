import 'package:equatable/equatable.dart';
import 'package:pdv/domain/entities/order.dart';

sealed class OrderPageEvent extends Equatable {}

class LoadData extends OrderPageEvent {
  final Order order;

  LoadData({required this.order});

  @override
  List<Object?> get props => [order];
}

class ToggleDiscount extends OrderPageEvent {
  final bool isToApplyDiscount;
  ToggleDiscount({required this.isToApplyDiscount});

  @override
  List<Object?> get props => [isToApplyDiscount];
}
