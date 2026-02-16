import 'package:drift/drift.dart';
import 'package:pdv/data/database/app_database.dart';
import 'package:pdv/domain/entities/order.dart';
import 'package:pdv/domain/entities/payment_method.dart';
import 'package:pdv/domain/extensions/int_extensions.dart';

extension OrderMapper on Order {
  OrderEntityCompanion toCompanion() => OrderEntityCompanion(
    id: Value.absent(),
    idempotencyKey: Value(idempotencyKey),
    totalCents: Value(totalCents),
    subTotalCents: Value(subTotalCents),
    serviceFeeCents: Value(serviceFeeCents),
    discountCents: Value(discountCents),
    paymentMethod: Value(paymentMethod),
    authCode: Value(authCode ?? ""),
    status: Value(status),
  );

  Map<String, Object> toReceiptMap() {
    List<String> lines = ["Mini POS - Recibo"];

    for (var item in items) {
      lines.add(
        '${item.product.name} x${item.quantity} ${item.subTotal.formatPrice(symbol: "").trim()}',
      );
    }

    String? paymentMethodName;

    if (paymentMethod == PaymentMethod.card) {
      paymentMethodName = "Cartão";
    }

    lines.addAll([
      "Subtotal: ${subTotalCents.formatPrice()}",
      "Taxa: ${serviceFeeCents.formatPrice()}",
      "Total: ${totalCents.formatPrice()}",
      if (paymentMethodName != null) "Pagamento: $paymentMethodName",
      if (authCode?.isNotEmpty ?? false) "Auth: $authCode",
    ]);

    return {"orderId": idempotencyKey, "lines": lines};
  }
}
