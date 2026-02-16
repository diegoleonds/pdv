import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pdv/data/entities/order_status.dart';
import 'package:pdv/domain/entities/order.dart';
import 'package:pdv/domain/extensions/int_extensions.dart';
import 'package:pdv/domain/service/payment/payment_service.dart';
import 'package:pdv/domain/service/print/print_service.dart';
import 'package:pdv/presentation/payment/payment_page_bloc.dart';
import 'package:pdv/presentation/payment/payment_page_event.dart';
import 'package:pdv/presentation/payment/payment_page_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPaymentService extends Mock implements PaymentService {}

class MockPrintService extends Mock implements PrintService {}

class FakeOrder extends Fake implements Order {}

void main() {
  final order = Order(id: 1, idempotencyKey: 'unique-key', totalCents: 1500);
  final processedOrder = order.copyWith(
    totalCents: 1500,
    status: OrderStatus.paid,
  );

  group('PaymentPageBloc', () {
    registerFallbackValue(FakeOrder());

    late MockPaymentService mockPaymentService;
    late MockPrintService mockPrintService;
    late PaymentPageBloc bloc;

    setUp(() {
      mockPaymentService = MockPaymentService();
      mockPrintService = MockPrintService();
      bloc = PaymentPageBloc(mockPaymentService, mockPrintService);
    });

    tearDown(() {
      bloc.close();
    });

    blocTest<PaymentPageBloc, PaymentPageState>(
      'LoadInitialData should processes payment and prints order and emits states in correct order',
      setUp: () {
        when(
          () => mockPaymentService.processPayment(order),
        ).thenAnswer((_) async => processedOrder);
        when(
          () => mockPrintService.print(processedOrder),
        ).thenAnswer((_) async => {});
      },
      build: () => bloc,
      act: (bloc) {
        bloc.add(LoadInitialData(order: order));
      },
      verify: (_) {
        verify(() => mockPaymentService.processPayment(order)).called(1);
        verify(() => mockPrintService.print(any())).called(1);
      },
      expect: () => [
        PaymentPageState(price: order.totalCents.formatPrice()),
        PaymentPageState(order: processedOrder),
      ],
    );
  });
}
