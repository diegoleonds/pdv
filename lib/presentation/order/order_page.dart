import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pdv/presentation/order/order_page_bloc.dart';
import 'package:pdv/presentation/order/order_page_event.dart';
import 'package:pdv/presentation/order/order_page_state.dart';

import '../../domain/entities/order.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key, required this.order});

  final Order order;

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    BlocProvider.of<OrderPageBloc>(
      context,
    ).add(LoadData(order: widget.order));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderPageBloc, OrderPageState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text("Pedido")),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              OrderCard(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Desconto",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Aplicar desconto",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Switch(
                          value: state.isDiscountApplied,
                          onChanged: (value) {
                            BlocProvider.of<OrderPageBloc>(
                              context,
                            ).add(ToggleDiscount(isToApplyDiscount: value));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              OrderCard(
                child: Column(
                  spacing: 10,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Subtotal",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          state.formattedSubtotalPrice,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    if (state.isDiscountApplied)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Desconto",
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            "-${state.formattedDiscountPrice}",
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Taxa (10%)",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          state.formattedTaxPrice,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          state.formattedTotalPrice,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          persistentFooterButtons: [
            ElevatedButton(
              onPressed: () {
                context.go(
                  "/payment",
                  extra: context.read<OrderPageBloc>().getOrder(),
                );
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
              child: Text('Prosseguir'),
            ),
          ],
        );
      },
    );
  }
}

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: Card(
        child: Padding(padding: const EdgeInsets.all(20), child: child),
      ),
    );
  }
}
