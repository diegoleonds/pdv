import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdv/presentation/dashboard/dashboard_page_bloc.dart';
import 'package:pdv/presentation/dashboard/dashboard_page_event.dart';
import 'package:pdv/presentation/widgets/card.dart';

import '../../data/entities/order_status.dart';
import 'dashboard_page_state.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    BlocProvider.of<DashboardPageBloc>(context).add(LoadingData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard")),
      body: BlocBuilder<DashboardPageBloc, DashboardPageState>(
        builder: (context, state) {
          if (state is DashboardFetchedState) {
            return Column(
              children: [
                OrderStatusCard(
                  status: OrderStatus.paid,
                  quantity: state.approvedPayments,
                  description: "Aprovadas",
                ),
                OrderStatusCard(
                  status: OrderStatus.pending,
                  quantity: state.pendingPayments,
                  description: "Pendentes",
                ),
                OrderStatusCard(
                  status: OrderStatus.failed,
                  quantity: state.failedPayments,
                  description: "Negadas",
                ),
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class OrderStatusCard extends StatelessWidget {
  const OrderStatusCard({
    super.key,
    required this.status,
    required this.quantity,
    required this.description,
  });

  final OrderStatus status;
  final int quantity;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              spacing: 10,
              children: [
                OrderStatusIcon(status: status, iconBgSize: 10, iconSize: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$quantity",
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge?.copyWith(fontSize: 24),
                    ),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  const DashboardCard({
    super.key,
    required this.quantity,
    required this.name,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
  });

  final int quantity;
  final String name;
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(17.0),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(7),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: iconBgColor,
              ),
              child: Icon(icon, color: iconColor, size: 25),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    quantity.toString(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(name, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
