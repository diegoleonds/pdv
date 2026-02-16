import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pdv/domain/extensions/int_extensions.dart';
import 'package:pdv/presentation/products/product_list_bloc.dart';
import 'package:pdv/presentation/products/product_list_state.dart';
import '../widgets/styles/app_colors.dart';
import 'product_list_event.dart';

class ProductsListPage extends StatefulWidget {
  const ProductsListPage({super.key});

  @override
  State<ProductsListPage> createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductListBloc>(context).add(LoadProducts());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductListBloc, ProductListState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(title: Text("Produtos")),
          body: _getBody(context, state),
          persistentFooterButtons: [
            ElevatedButton(
              onPressed: state.isButtonEnabled
                  ? () {
                      context.push(
                        "/order",
                        extra: BlocProvider.of<ProductListBloc>(
                          context,
                        ).getOrder(),
                      );
                    }
                  : null,
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

Widget _getBody(BuildContext context, ProductListState state) {
  final items = state.items;
  return ListView.builder(
    itemCount: items.length,
    itemBuilder: (context, index) {
      final item = items[index];

      return ProductItem(
        name: item.product.name,
        value: item.product.priceCents.formatPrice(),
        quantity: item.quantity,
        onPressed: () {
          BlocProvider.of<ProductListBloc>(
            context,
          ).add(AddProductToCart(items[index]));
        },
        onIncreasePressed: () {
          BlocProvider.of<ProductListBloc>(
            context,
          ).add(IncreaseProductQuantity(items[index]));
        },
        onDecreasePressed: () {
          BlocProvider.of<ProductListBloc>(
            context,
          ).add(DecreaseProductQuantity(items[index]));
        },
        onDeletePressed: () {
          BlocProvider.of<ProductListBloc>(
            context,
          ).add(DeleteProduct(items[index]));
        },
      );
    },
  );
}

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.name,
    required this.value,
    required this.quantity,
    required this.onPressed,
    required this.onIncreasePressed,
    required this.onDecreasePressed,
    required this.onDeletePressed,
  });

  final String name;
  final String value;
  final int quantity;
  final VoidCallback onPressed;
  final VoidCallback onIncreasePressed;
  final VoidCallback onDecreasePressed;
  final VoidCallback onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: Theme.of(context).textTheme.titleMedium),
                Text(value, style: Theme.of(context).textTheme.titleSmall),
              ],
            ),
            QuantityButton(
              quantity: quantity,
              onPressed: onPressed,
              onIncreasePressed: onIncreasePressed,
              onDecreasePressed: onDecreasePressed,
              onDeletePressed: onDeletePressed,
            ),
          ],
        ),
      ),
    );
  }
}

class QuantityButton extends StatelessWidget {
  const QuantityButton({
    super.key,
    required this.quantity,
    required this.onPressed,
    required this.onIncreasePressed,
    required this.onDecreasePressed,
    required this.onDeletePressed,
  });

  final int quantity;
  final VoidCallback onPressed;
  final VoidCallback onIncreasePressed;
  final VoidCallback onDecreasePressed;
  final VoidCallback onDeletePressed;

  @override
  Widget build(BuildContext context) {
    if (quantity == 0) {
      return ElevatedButton(onPressed: onPressed, child: Text("Adicionar"));
    } else {
      return Row(
        children: [
          IconButton(
            onPressed: onDeletePressed,
            icon: Icon(Icons.delete_outline, color: AppColors.deleteIconColor),
          ),
          IconButton(
            onPressed: onDecreasePressed,
            icon: Icon(Icons.remove_outlined),
          ),
          Text(
            quantity.toString(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          IconButton(
            onPressed: onIncreasePressed,
            icon: Icon(Icons.add_outlined),
          ),
        ],
      );
    }
  }
}
