import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdv/data/entities/order_status.dart';
import 'package:pdv/domain/entities/payment_method.dart';
import 'package:pdv/domain/extensions/int_extensions.dart';
import 'package:pdv/presentation/order/order_page_event.dart';
import 'package:pdv/presentation/order/order_page_state.dart';

import '../../domain/entities/order.dart';

class OrderPageBloc extends Bloc<OrderPageEvent, OrderPageState> {
  OrderPageBloc() : super(OrderPageState()) {
    on<LoadData>(_onLoadData);
    on<ToggleDiscount>(_onToggleDiscount);
  }

  late Order _order;
  int _totalPrice = 0;

  void _onLoadData(LoadData event, Emitter<OrderPageState> emitter) {
    _order = event.order;
    final items = _order.items;

    int subtotalPrice = 0;
    for (var item in items) {
      subtotalPrice += item.product.priceCents * item.quantity;
    }
    int serviceFee = (subtotalPrice * 0.1).toInt();
    _totalPrice = subtotalPrice + serviceFee;

    _order = _order.copyWith(
      totalCents: _totalPrice,
      subTotalCents: subtotalPrice,
      discountCents: 0,
      paymentMethod: PaymentMethod.card,
      serviceFeeCents: serviceFee,
      items: items,
      status: OrderStatus.draft,
    );

    emitter.call(
      OrderPageState(
        formattedTotalPrice: _totalPrice.formatPrice(),
        formattedSubtotalPrice: subtotalPrice.formatPrice(),
        formattedTaxPrice: serviceFee.formatPrice(),
      ),
    );
  }

  void _onToggleDiscount(
    ToggleDiscount event,
    Emitter<OrderPageState> emitter,
  ) {
    if (event.isToApplyDiscount) {
      int discount = (_totalPrice * 0.05).toInt();
      int totalWithDiscount = _totalPrice - discount;

      _order = _order.copyWith(
        totalCents: totalWithDiscount,
        discountCents: discount,
      );

      emitter.call(
        state.copyWith(
          isDiscountApplied: true,
          formattedDiscountPrice: discount.formatPrice(),
          formattedTotalPrice: totalWithDiscount.formatPrice(),
        ),
      );
    } else {
      _order = _order.copyWith(totalCents: _totalPrice, discountCents: 0);
      emitter.call(
        state.copyWith(
          isDiscountApplied: false,
          formattedDiscountPrice: "",
          formattedTotalPrice: _order.totalCents.formatPrice(),
        ),
      );
    }
  }

  Order getOrder() => _order;
}
