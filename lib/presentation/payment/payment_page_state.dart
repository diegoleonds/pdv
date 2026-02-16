import 'package:equatable/equatable.dart';

import '../../domain/entities/order.dart';

class PaymentPageState extends Equatable {
  final String price;
  final Order? order;

  PaymentPageState({this.price = "", this.order});

  @override
  List<Object?> get props => [price, order];
}
