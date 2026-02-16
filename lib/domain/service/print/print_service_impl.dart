import 'package:flutter/services.dart';
import 'package:pdv/domain/service/print/print_service.dart';

import '../../../data/entities/order_status.dart';
import '../../entities/order.dart';
import '../../mapper/order_mapper.dart';

class PrintServiceImpl implements PrintService {
  final MethodChannel channel;
  final String printMethod = 'printReceipt';

  PrintServiceImpl({
    this.channel = const MethodChannel("com.company.smartpos/terminal"),
  });

  @override
  Future print(Order order) async {
    if (order.status == OrderStatus.paid) {
      channel.invokeMethod(printMethod, order.toReceiptMap());
    }
  }
}
