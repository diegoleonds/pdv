import 'package:flutter/services.dart';
import 'package:pdv/data/entities/order_status.dart';
import 'package:pdv/domain/service/connectivity/connectivity_service.dart';
import 'package:pdv/domain/service/connectivity/connectivity_status.dart';
import 'package:pdv/domain/service/payment/payment_service.dart';
import '../../entities/order.dart';
import '../../usecase/insert_order_with_cart_items_use_case.dart';
import 'payment_status.dart';

class PaymentServiceImpl implements PaymentService {
  final MethodChannel requestCardChannel;

  final InsertOrderWithCartItemsUseCase _insertOrderWithCartItemsUseCase;

  final ConnectivityService _connectivityService;

  final int maxAttempts = 3;
  final timeout = 15000;

  PaymentServiceImpl(
    this._insertOrderWithCartItemsUseCase,
    this._connectivityService, [
    this.requestCardChannel = const MethodChannel(
      "com.company.smartpos/terminal",
    ),
  ]);

  @override
  Future<Order> processPayment(Order order) async {
    Order updatedOrder = order;
    int currentAttempt = 1;
    ConnectivityStatus connectivityStatus;

    for (; currentAttempt <= maxAttempts; currentAttempt++) {
      connectivityStatus = await _connectivityService.checkConnectivity();

      if (connectivityStatus == ConnectivityStatus.offline) {
        if (currentAttempt == maxAttempts) {
          updatedOrder = updatedOrder.copyWith(
            status: OrderStatus.pending,
            authCode: "",
          );
          int orderId = await _insertOrderWithCartItemsUseCase.call(
            updatedOrder,
          );
          updatedOrder = updatedOrder.copyWith(id: orderId);

          return updatedOrder;
        } else {
          continue;
        }
      }

      final channelResult = await requestCardChannel
          .invokeMethod("requestCardPayment", {
            "orderId": order.idempotencyKey,
            "amountCents": order.totalCents,
            "forceOutcome": "RANDOM",
            "timeoutMs": "$timeout",
          });

      final authCode = channelResult["authCode"] ?? "";

      updatedOrder = updatedOrder.copyWith(
        status: OrderStatus.failed,
        authCode: authCode,
      );

      final result = Map<String, String>.from(channelResult as Map);
      final PaymentStatus status = PaymentStatus.values.firstWhere(
        (ps) =>
            ps.name.toLowerCase() == (result["status"] as String).toLowerCase(),
        orElse: () => PaymentStatus.error,
      );

      switch (status) {
        case PaymentStatus.approved:
          updatedOrder = updatedOrder.copyWith(
            status: OrderStatus.paid,
            authCode: authCode,
          );
          break;
        case PaymentStatus.timeout:
          if (currentAttempt <= maxAttempts) {
            continue;
          }
          updatedOrder = updatedOrder.copyWith(
            status: OrderStatus.pending,
            authCode: authCode,
          );
          break;
        default:
          updatedOrder = updatedOrder.copyWith(
            status: OrderStatus.failed,
            authCode: authCode,
          );
      }
      await _insertOrderWithCartItemsUseCase.call(updatedOrder);
      return updatedOrder;
    }
    await _insertOrderWithCartItemsUseCase.call(
      updatedOrder.copyWith(status: OrderStatus.failed),
    );
    return updatedOrder;
  }
}
