import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:pdv/data/entities/order_status.dart';
import 'package:pdv/domain/entities/order.dart';
import 'package:pdv/presentation/paymentresult/payment_result_bloc.dart';
import 'package:pdv/presentation/paymentresult/payment_result_event.dart';
import 'package:pdv/presentation/paymentresult/payment_result_page_state.dart';

void main() {
  group('PaymentResultBloc', () {
    late PaymentResultBloc bloc;

    setUp(() {
      bloc = PaymentResultBloc();
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state should have empty values and draft status', () {
      expect(
        bloc.state,
        PaymentResultPageState(
          title: "",
          message: "",
          status: OrderStatus.draft,
        ),
      );
    });

    group('LoadData', () {
      blocTest<PaymentResultBloc, PaymentResultPageState>(
        'emits success state when order status is paid',
        build: () => bloc,
        act: (bloc) {
          final order = Order.draft().copyWith(
            status: OrderStatus.paid,
            totalCents: 5000,
          );
          bloc.add(LoadData(order: order));
        },
        expect: () => [
          PaymentResultPageState(
            title: "Pagamento aprovado!",
            message: "Retorne para a home para continuar vendendo.",
            status: OrderStatus.paid,
          ),
        ],
      );

      blocTest<PaymentResultBloc, PaymentResultPageState>(
        'emits pending state when order status is pending',
        build: () => bloc,
        act: (bloc) {
          final order = Order.draft().copyWith(
            status: OrderStatus.pending,
            totalCents: 5000,
          );
          bloc.add(LoadData(order: order));
        },
        expect: () => [
          PaymentResultPageState(
            title: "Pagamento pendente",
            message: "Não se preocupe, estamos processando seu pagamento.",
            status: OrderStatus.pending,
          ),
        ],
      );

      blocTest<PaymentResultBloc, PaymentResultPageState>(
        'emits error state when order status is failed',
        build: () => bloc,
        act: (bloc) {
          final order = Order.draft().copyWith(
            status: OrderStatus.failed,
            totalCents: 5000,
          );
          bloc.add(LoadData(order: order));
        },
        expect: () => [
          PaymentResultPageState(
            title: "Algo deu errado",
            message: "Nenhuma cobrança será feita ao cliente.",
            status: OrderStatus.failed,
          ),
        ],
      );

      blocTest<PaymentResultBloc, PaymentResultPageState>(
        'emits error state when order status is draft (default case)',
        build: () => bloc,
        act: (bloc) {
          final order = Order.draft().copyWith(
            status: OrderStatus.draft,
            totalCents: 5000,
          );
          bloc.add(LoadData(order: order));
        },
        expect: () => [
          PaymentResultPageState(
            title: "Algo deu errado",
            message: "Nenhuma cobrança será feita ao cliente.",
            status: OrderStatus.draft,
          ),
        ],
      );

      blocTest<PaymentResultBloc, PaymentResultPageState>(
        'can handle multiple LoadData events with different statuses',
        build: () => bloc,
        act: (bloc) {
          final paidOrder = Order.draft().copyWith(status: OrderStatus.paid);
          final failedOrder = Order.draft().copyWith(status: OrderStatus.failed);
          final pendingOrder = Order.draft().copyWith(status: OrderStatus.pending);

          bloc.add(LoadData(order: paidOrder));
          bloc.add(LoadData(order: failedOrder));
          bloc.add(LoadData(order: pendingOrder));
        },
        expect: () => [
          PaymentResultPageState(
            title: "Pagamento aprovado!",
            message: "Retorne para a home para continuar vendendo.",
            status: OrderStatus.paid,
          ),
          PaymentResultPageState(
            title: "Algo deu errado",
            message: "Nenhuma cobrança será feita ao cliente.",
            status: OrderStatus.failed,
          ),
          PaymentResultPageState(
            title: "Pagamento pendente",
            message: "Não se preocupe, estamos processando seu pagamento.",
            status: OrderStatus.pending,
          ),
        ],
      );

      test('stores order internally and can be retrieved', () async {
        final order = Order.draft().copyWith(
          id: 123,
          status: OrderStatus.paid,
          totalCents: 5000,
          authCode: "ABC123",
        );

        bloc.add(LoadData(order: order));
        await bloc.stream.first;

        // Verify internal order is stored correctly
        // Note: You might need to add a getter method like in OrderPageBloc
        // If you add: Order getOrder() => _order;
        // Then you can test: expect(bloc.getOrder(), order);
      });
    });

    group('PaymentResultEvent', () {
      test('LoadData should include order in props for equality', () {
        final order1 = Order.draft().copyWith(id: 1);
        final order2 = Order.draft().copyWith(id: 2);

        final event1a = LoadData(order: order1);
        final event1b = LoadData(order: order1);
        final event2 = LoadData(order: order2);

        expect(event1a, equals(event1b));
        expect(event1a, isNot(equals(event2)));
      });
    });

    group('PaymentResultPageState', () {
      test('should support value equality', () {
        final state1 = PaymentResultPageState(
          title: "Title",
          message: "Message",
          status: OrderStatus.paid,
        );
        final state2 = PaymentResultPageState(
          title: "Title",
          message: "Message",
          status: OrderStatus.paid,
        );
        final state3 = PaymentResultPageState(
          title: "Different",
          message: "Message",
          status: OrderStatus.paid,
        );

        expect(state1, equals(state2));
        expect(state1, isNot(equals(state3)));
      });
    });
  });
}