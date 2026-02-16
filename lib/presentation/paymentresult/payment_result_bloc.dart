import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdv/data/entities/order_status.dart';
import 'package:pdv/domain/entities/order.dart';
import 'package:pdv/presentation/paymentresult/payment_result_event.dart';
import 'package:pdv/presentation/paymentresult/payment_result_page_state.dart';

class PaymentResultBloc
    extends Bloc<PaymentResultEvent, PaymentResultPageState> {
  PaymentResultBloc() : super(PaymentResultPageState()) {
    on<LoadData>(_onLoadData);
  }

  late Order _order;

  void _onLoadData(LoadData event, Emitter<PaymentResultPageState> emitter) {
    _order = event.order;
    final status = _order.status;

    switch (status) {
      case OrderStatus.paid:
        emitter.call(
          PaymentResultPageState(
            title: "Pagamento aprovado!",
            message: "Retorne para a home para continuar vendendo.",
            status: status,
          ),
        );
        break;
      case OrderStatus.pending:
        emitter.call(
          PaymentResultPageState(
            title: "Pagamento pendente",
            message:
                "Não se preocupe, estamos processando seu pagamento.",
            status: status,
          ),
        );
        break;
      default:
        emitter.call(
          PaymentResultPageState(
            title: "Algo deu errado",
            message: "Nenhuma cobrança será feita ao cliente.",
            status: status,
          ),
        );
    }
  }
}
