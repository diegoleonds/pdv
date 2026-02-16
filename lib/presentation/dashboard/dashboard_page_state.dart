import 'package:equatable/equatable.dart';

sealed class DashboardPageState extends Equatable {}

class LoadingState extends DashboardPageState {
  @override
  List<Object?> get props => [];
}

class DashboardFetchedState extends DashboardPageState {
  final int approvedPayments;
  final int pendingPayments;
  final int failedPayments;

  DashboardFetchedState({
    required this.approvedPayments,
    required this.pendingPayments,
    required this.failedPayments,
  });

  @override
  List<Object?> get props => [approvedPayments, pendingPayments, failedPayments];
}
