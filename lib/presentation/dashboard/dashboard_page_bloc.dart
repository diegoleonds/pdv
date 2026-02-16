import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdv/data/entities/order_status.dart';
import 'package:pdv/data/order/order_repository.dart';
import 'package:pdv/presentation/dashboard/dashboard_page_event.dart';
import 'package:pdv/presentation/dashboard/dashboard_page_state.dart';

class DashboardPageBloc extends Bloc<DashboardPageEvent, DashboardPageState> {
  DashboardPageBloc(this._repository) : super(LoadingState()) {
    on<LoadingData>(_onLoadingData);
  }

  final OrderRepository _repository;

  void _onLoadingData(
    LoadingData event,
    Emitter<DashboardPageState> emitter,
  ) async {
    emitter.call(LoadingState());

    final statusQuantities = await _repository.getOrderCountByStatus();

    final approvedPayments = statusQuantities[OrderStatus.paid] ?? 0;
    final pendingPayments = statusQuantities[OrderStatus.pending] ?? 0;
    final failedPayments = statusQuantities[OrderStatus.failed] ?? 0;

    emitter.call(
      DashboardFetchedState(
        approvedPayments: approvedPayments,
        pendingPayments: pendingPayments,
        failedPayments: failedPayments,
      ),
    );
  }
}
