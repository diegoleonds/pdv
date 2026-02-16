import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pdv/data/entities/order_status.dart';
import 'package:pdv/data/order/order_repository.dart';
import 'package:pdv/presentation/dashboard/dashboard_page_bloc.dart';
import 'package:pdv/presentation/dashboard/dashboard_page_event.dart';
import 'package:pdv/presentation/dashboard/dashboard_page_state.dart';

class OrderRepositoryMock extends Mock implements OrderRepository {}

void main() {
  group('DashboardBloc', () {
    final mockOrderRepository = OrderRepositoryMock();

    when(() => mockOrderRepository.getOrderCountByStatus()).thenAnswer(
      (_) async => {
        OrderStatus.paid: 1,
        OrderStatus.failed: 1,
        OrderStatus.pending: 1,
      },
    );

    blocTest<DashboardPageBloc, DashboardPageState>(
      'bloc should emit Loading and then DashboardFetchedState when LoadingData event is called',
      build: () => DashboardPageBloc(mockOrderRepository),
      act: (bloc) => bloc.add(LoadingData()),
      expect: () => <DashboardPageState>[
        LoadingState(),
        DashboardFetchedState(
          approvedPayments: 1,
          pendingPayments: 1,
          failedPayments: 1,
        ),
      ],
    );
  });

  group('DashboardBloc', () {
    final mockOrderRepository = OrderRepositoryMock();

    when(() => mockOrderRepository.getOrderCountByStatus()).thenAnswer(
          (_) async => {
        OrderStatus.failed: 1,
        OrderStatus.pending: 1,
      },
    );

    blocTest<DashboardPageBloc, DashboardPageState>(
      'bloc should set approvedPayments as 0 when its not in the map retuned from repo',
      build: () => DashboardPageBloc(mockOrderRepository),
      act: (bloc) => bloc.add(LoadingData()),
      skip: 1,
      expect: () => <DashboardPageState>[
        DashboardFetchedState(
          approvedPayments: 0,
          pendingPayments: 1,
          failedPayments: 1,
        ),
      ],
    );
  });

  group('DashboardBloc', () {
    final mockOrderRepository = OrderRepositoryMock();

    when(() => mockOrderRepository.getOrderCountByStatus()).thenAnswer(
          (_) async => {
        OrderStatus.paid: 1,
        OrderStatus.pending: 1,
      },
    );

    blocTest<DashboardPageBloc, DashboardPageState>(
      'bloc should set failedPayments as 0 when its not in the map retuned from repo',
      build: () => DashboardPageBloc(mockOrderRepository),
      act: (bloc) => bloc.add(LoadingData()),
      skip: 1,
      expect: () => <DashboardPageState>[
        DashboardFetchedState(
          approvedPayments: 1,
          pendingPayments: 1,
          failedPayments: 0,
        ),
      ],
    );
  });

  group('DashboardBloc', () {
    final mockOrderRepository = OrderRepositoryMock();

    when(() => mockOrderRepository.getOrderCountByStatus()).thenAnswer(
          (_) async => {
        OrderStatus.paid: 1,
        OrderStatus.failed: 1,
      },
    );

    blocTest<DashboardPageBloc, DashboardPageState>(
      'bloc should set pendingPayments as 0 when its not in the map retuned from repo',
      build: () => DashboardPageBloc(mockOrderRepository),
      act: (bloc) => bloc.add(LoadingData()),
      skip: 1,
      expect: () => <DashboardPageState>[
        DashboardFetchedState(
          approvedPayments: 1,
          pendingPayments: 0,
          failedPayments: 1,
        ),
      ],
    );
  });
}
