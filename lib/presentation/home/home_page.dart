import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/styles/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PDV")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 18),
            child: CardOption(
              title: 'Produtos',
              description: 'Acessar catálogo',
              icon: Icons.shopping_bag_outlined,
              onTap: () {
                context.push("/products");
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7),
            child: CardOption(
              title: 'Dashboard',
              description: 'Relatórios e métricas ',
              icon: Icons.bar_chart_outlined,
              onTap: () {
                context.push("/dashboard");
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CardOption extends StatelessWidget {
  const CardOption({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String description;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Card(
        clipBehavior: Clip.hardEdge,
        elevation: 0,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.iconBackgroundGrey,
                        ),
                        child: Icon(icon),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            description,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
