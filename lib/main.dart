import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pdv/data/cartitem/cart_item_dao.dart';
import 'package:pdv/data/order/order_dao.dart';
import 'package:pdv/data/products/product_dao.dart';
import 'package:pdv/domain/service/print/print_service_impl.dart';
import 'package:pdv/presentation/widgets/styles/app_theme.dart';
import 'package:pdv/data/cartitem/cart_item_repository.dart';
import 'package:pdv/data/database/app_database.dart';
import 'package:pdv/data/order/order_repository_impl.dart';
import 'package:pdv/data/products/product_repository.dart';
import 'package:pdv/data/products/product_repository_impl.dart';
import 'package:pdv/domain/service/connectivity/connectivity_service_impl.dart';
import 'package:pdv/domain/service/payment/payment_service_impl.dart';
import 'package:pdv/domain/usecase/insert_order_with_cart_items_use_case.dart';
import 'package:pdv/presentation/dashboard/dashboard_page_bloc.dart';
import 'package:pdv/presentation/order/order_page.dart';
import 'package:pdv/presentation/order/order_page_bloc.dart';
import 'package:pdv/presentation/payment/payment_page.dart';
import 'package:pdv/presentation/payment/payment_page_bloc.dart';
import 'package:pdv/presentation/paymentresult/payment_result_bloc.dart';
import 'package:pdv/presentation/paymentresult/payment_result_page.dart';
import 'package:pdv/presentation/products/product_list_bloc.dart';
import 'package:pdv/router/app_router.dart';
import 'data/cartitem/cart_item_repository_impl.dart';
import 'data/order/order_repository.dart';
import 'domain/entities/order.dart';
import 'presentation/dashboard/dashboard_page.dart';
import 'presentation/home/home_page.dart';
import 'presentation/products/products_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ProductRepository>(
          create: (context) => ProductRepositoryImpl(ProductDao(AppDatabase())),
        ),
        RepositoryProvider<OrderRepository>(
          create: (context) =>
              OrderRepositoryImpl(dao: OrderDao(AppDatabase())),
        ),
        RepositoryProvider<CartItemRepository>(
          create: (context) =>
              CartItemRepositoryImpl(dao: CartItemDao(AppDatabase())),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                ProductListBloc(context.read<ProductRepository>()),
          ),
          BlocProvider(create: (context) => OrderPageBloc()),
          BlocProvider(
            create: (context) => PaymentPageBloc(
              PaymentServiceImpl(
                InsertOrderWithCartItemsUseCase(
                  context.read<OrderRepository>(),
                  context.read<CartItemRepository>(),
                ),
                ConnectivityServiceImpl(),
              ),
              PrintServiceImpl(),
            ),
          ),
          BlocProvider(create: (context) => PaymentResultBloc()),
          BlocProvider(
            create: (context) =>
                DashboardPageBloc(context.read<OrderRepository>()),
          ),
        ],
        child: MaterialApp.router(
          title: 'PDV',
          theme: appTheme(),
          routerConfig: appRouter,
        ),
      ),
    );
  }
}
