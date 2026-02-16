import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdv/domain/extensions/int_extensions.dart';
import 'package:pdv/domain/service/payment/payment_service.dart';
import 'package:pdv/domain/service/print/print_service.dart';
import 'package:pdv/presentation/payment/payment_page_event.dart';
import 'package:pdv/presentation/payment/payment_page_state.dart';
import '../../domain/entities/order.dart';

class PaymentPageBloc extends Bloc<PaymentPageEvent, PaymentPageState> {
  PaymentPageBloc(this._paymentService, this._printService)
    : super(PaymentPageState()) {
    on<LoadInitialData>(_onLoadInitialData);
  }

  final PaymentService _paymentService;
  final PrintService _printService;

  late Order _order;

  void _onLoadInitialData(
    LoadInitialData event,
    Emitter<PaymentPageState> emitter,
  ) async {
    _order = event.order;
    emitter.call(PaymentPageState(price: _order.totalCents.formatPrice()));

    _order = await _paymentService.processPayment(_order);
    await _printService.print(_order);

    emitter.call(PaymentPageState(order: _order));
  }
}
