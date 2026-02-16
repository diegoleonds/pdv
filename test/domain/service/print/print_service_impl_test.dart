import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pdv/data/entities/order_status.dart';
import 'package:pdv/domain/entities/order.dart';
import 'package:pdv/domain/service/print/print_service_impl.dart';

class MethodChannelMock extends Mock implements MethodChannel {}

void main() {
  test('print should be called when order is in paid status', () async {
    final channel = MethodChannelMock();
    final service = PrintServiceImpl(channel: channel);
    final order = Order.draft().copyWith(status: OrderStatus.paid);

    when(() => channel.invokeMethod<dynamic>(any(), any()))
        .thenAnswer((_) async => null);

    await service.print(order);

    verify(() => channel.invokeMethod(service.printMethod, any())).called(1);
  });

  test('print should not be called when order is not in paid status', () {
    final channel = MethodChannelMock();
    final service = PrintServiceImpl(channel: channel);

    service.print(Order.draft());
    verifyNever(() => channel.invokeMethod(service.printMethod));
  });
}