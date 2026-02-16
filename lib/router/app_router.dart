import 'package:go_router/go_router.dart';
import 'package:pdv/router/router_paths.dart';

import '../domain/entities/order.dart';
import '../presentation/dashboard/dashboard_page.dart';
import '../presentation/home/home_page.dart';
import '../presentation/order/order_page.dart';
import '../presentation/payment/payment_page.dart';
import '../presentation/paymentresult/payment_result_page.dart';
import '../presentation/products/products_list_page.dart';

final appRouter = GoRouter(
  initialLocation: RouterPaths.home,
  routes: [
    GoRoute(path: RouterPaths.home, builder: (context, state) => HomePage()),
    GoRoute(path: RouterPaths.products, builder: (context, state) => ProductsListPage()),
    GoRoute(path: RouterPaths.dashboard, builder: (context, state) => DashboardPage()),
    GoRoute(
      path: RouterPaths.order,
      builder: (context, state) => OrderPage(order: state.extra as Order),
    ),
    GoRoute(
      path: RouterPaths.payment,
      builder: (context, state) => PaymentPage(order: state.extra as Order),
    ),
    GoRoute(
      path: RouterPaths.paymentResult,
      builder: (context, state) => PaymentResultPage(order: state.extra as Order),
    ),
  ],
);