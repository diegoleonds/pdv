import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pdv/presentation/paymentresult/payment_result_bloc.dart';
import 'package:pdv/presentation/paymentresult/payment_result_event.dart';
import 'package:pdv/presentation/paymentresult/payment_result_page_state.dart';
import '../../domain/entities/order.dart';
import '../widgets/card.dart';

class PaymentResultPage extends StatefulWidget {
  const PaymentResultPage({super.key, required this.order});
  final Order order;

  @override
  State<PaymentResultPage> createState() => _PaymentResultPageState();
}

class _PaymentResultPageState extends State<PaymentResultPage> {
  @override
  void initState() {
    BlocProvider.of<PaymentResultBloc>(
      context,
    ).add(LoadData(order: widget.order));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentResultBloc, PaymentResultPageState>(
      builder: (context, state) {
        return Scaffold(
          body: Card(
            margin: EdgeInsets.fromLTRB(40, 200, 40, 0),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: OrderStatusIcon(status: state.status),
                  ),
                  Text(
                    state.title,
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    margin: EdgeInsets.all(7),
                    child: Text(
                      state.message,
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          persistentFooterButtons: [
            ElevatedButton(
              onPressed: () {
                context.go("/");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: Size(double.infinity, 42),
              ),
              child: Text('Continuar vendendo'),
            ),
          ],
        );
      },
    );
  }
}
