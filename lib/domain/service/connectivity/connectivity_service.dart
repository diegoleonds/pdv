import 'package:pdv/domain/service/connectivity/connectivity_status.dart';

abstract class ConnectivityService {
  Future<ConnectivityStatus> checkConnectivity();
}
