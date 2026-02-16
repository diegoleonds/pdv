import 'package:flutter/services.dart';
import 'package:pdv/domain/service/connectivity/connectivity_service.dart';
import 'package:pdv/domain/service/connectivity/connectivity_status.dart';

class ConnectivityServiceImpl implements ConnectivityService {
  final MethodChannel terminalChannel;
  final String checkConnectivityMethod = "checkConnectivity";

  ConnectivityServiceImpl({
    this.terminalChannel = const MethodChannel("com.company.smartpos/terminal"),
  });

  @override
  Future<ConnectivityStatus> checkConnectivity() async {
    try {
      final result = await terminalChannel.invokeMethod(checkConnectivityMethod);
      final status = Map<String, String>.from(result as Map);

      return ConnectivityStatus.values.firstWhere(
        (cs) =>
            cs.name.toLowerCase() ==
            (status["network"] as String).toLowerCase(),
        orElse: () => ConnectivityStatus.offline,
      );
    } catch (e) {
      return ConnectivityStatus.offline;
    }
  }
}
