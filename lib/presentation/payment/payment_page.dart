import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pdv/presentation/widgets/styles/app_colors.dart';
import 'package:pdv/presentation/payment/payment_page_bloc.dart';
import 'package:pdv/presentation/payment/payment_page_event.dart';
import 'package:pdv/presentation/payment/payment_page_state.dart';

import '../../domain/entities/order.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key, required this.order});

  final Order order;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  void initState() {
    BlocProvider.of<PaymentPageBloc>(
      context,
    ).add(LoadInitialData(order: widget.order));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentPageBloc, PaymentPageState>(
      listener: (context, state) {
        if (state.order != null) {
          context.go("/payment_result", extra: state.order);
        }
      },
      builder: (BuildContext context, PaymentPageState state) {
        return Scaffold(
          appBar: AppBar(title: Text("Pagamento")),
          body: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 25,
              children: [
                Text(
                  state.price,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontSize: 25),
                  textAlign: TextAlign.center,
                ),
                Container(
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: AppColors.onBackground,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.credit_card, size: 60),
                ),
                Text(
                  "Aproxime, insira ou passe o cartão\n para pagar",
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                Row(),
              ],
            ),
          ),
        );
      },
    );
  }
}
