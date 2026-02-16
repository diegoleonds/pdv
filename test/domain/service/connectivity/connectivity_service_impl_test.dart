import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pdv/domain/service/connectivity/connectivity_service_impl.dart';
import 'package:pdv/domain/service/connectivity/connectivity_status.dart';

class MethodChannelMock extends Mock implements MethodChannel {}

void main() {
  test('checkConnectivity should return offline when channel returns it', () async {
    final channel = MethodChannelMock();
    final service = ConnectivityServiceImpl(terminalChannel: channel);

    when(() => channel.invokeMethod(service.checkConnectivityMethod)).thenAnswer(
      (_) async => {"network": ConnectivityStatus.offline.name.toLowerCase()},
    );

    final status = await service.checkConnectivity();

    expect(status, ConnectivityStatus.offline);
  });

  test('checkConnectivity should return offline when channel throws an exception', () async {
    final channel = MethodChannelMock();
    final service = ConnectivityServiceImpl(terminalChannel: channel);

    when(() => channel.invokeMethod(service.checkConnectivityMethod)).thenAnswer(
          (_) async => throw PlatformException(code: "ERROR", message: "Failed to check connectivity"),
    );

    final status = await service.checkConnectivity();

    expect(status, ConnectivityStatus.offline);
  });

  test('checkConnectivity should return online when channel returns it', () async {
    final channel = MethodChannelMock();
    final service = ConnectivityServiceImpl(terminalChannel: channel);

    when(() => channel.invokeMethod(service.checkConnectivityMethod)).thenAnswer(
          (_) async => {"network": ConnectivityStatus.online.name.toLowerCase()},
    );

    final status = await service.checkConnectivity();

    expect(status, ConnectivityStatus.online);
  });
}