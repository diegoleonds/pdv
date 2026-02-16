import 'package:equatable/equatable.dart';
import 'package:pdv/domain/entities/payment_method.dart';
import 'package:uuid/uuid.dart';
import '../../data/entities/order_status.dart';
import 'cart_item.dart';

class Order extends Equatable {
  final int? id;
  final String idempotencyKey;
  final int totalCents;
  final int subTotalCents;
  final int discountCents;
  final int serviceFeeCents;
  final OrderStatus status;
  final PaymentMethod paymentMethod;
  final List<CartItem> items;
  final String? authCode;

  Order({
    this.id,
    required this.idempotencyKey,
    this.items = const [],
    this.totalCents = 0,
    this.subTotalCents = 0,
    this.discountCents = 0,
    this.serviceFeeCents = 0,
    this.status = OrderStatus.draft,
    this.paymentMethod = PaymentMethod.card,
    this.authCode,
  });

  Order.draft()
    : id = null,
      idempotencyKey = Uuid().v4(),
      items = const [],
      totalCents = 0,
      subTotalCents = 0,
      discountCents = 0,
      serviceFeeCents = 0,
      authCode = null,
      status = OrderStatus.draft,
      paymentMethod = PaymentMethod.card;

  Order copyWith({
    int? id,
    String? idempotencyKey,
    int? totalCents,
    int? subTotalCents,
    int? discountCents,
    int? serviceFeeCents,
    String? authCode,
    List<CartItem>? items,
    OrderStatus? status,
    PaymentMethod? paymentMethod,
  }) => Order(
    id: id ?? this.id,
    idempotencyKey: idempotencyKey ?? this.idempotencyKey,
    totalCents: totalCents ?? this.totalCents,
    subTotalCents: subTotalCents ?? this.subTotalCents,
    discountCents: discountCents ?? this.discountCents,
    serviceFeeCents: serviceFeeCents ?? this.serviceFeeCents,
    status: status ?? this.status,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    items: items ?? this.items,
    authCode: authCode ?? this.authCode,
  );

  @override
  List<Object?> get props => [
    id,
    idempotencyKey,
    totalCents,
    subTotalCents,
    discountCents,
    serviceFeeCents,
    authCode,
    items,
    status,
    paymentMethod,
  ];
}
