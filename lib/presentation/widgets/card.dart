import 'package:flutter/material.dart';
import 'styles/app_colors.dart';
import '../../data/entities/order_status.dart';

class OrderStatusIcon extends StatelessWidget {
  const OrderStatusIcon({
    super.key,
    required this.status,
    this.iconSize = 27,
    this.iconBgSize = 14,
  });

  final OrderStatus status;
  final double iconSize;
  final double iconBgSize;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case OrderStatus.paid:
        return ResultIcon(
          icon: Icons.check,
          iconColor: AppColors.success,
          bgColor: AppColors.successLight,
          iconSize: iconSize,
          iconBgSize: iconBgSize,
        );
      case OrderStatus.pending:
        return ResultIcon(
          icon: Icons.warning,
          iconColor: AppColors.warning,
          bgColor: AppColors.warningLight,
          iconSize: iconSize,
          iconBgSize: iconBgSize,
        );
      default:
        return ResultIcon(
          icon: Icons.error_outline,
          iconColor: AppColors.error,
          bgColor: AppColors.errorLight,
          iconSize: iconSize,
          iconBgSize: iconBgSize,
        );
    }
  }
}

class ResultIcon extends StatelessWidget {
  const ResultIcon({
    super.key,
    required this.icon,
    required this.bgColor,
    this.iconColor = Colors.white,
    this.iconSize = 27,
    this.iconBgSize = 14,
  });

  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  final double iconSize;
  final double iconBgSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(iconBgSize),
      decoration: BoxDecoration(shape: BoxShape.circle, color: bgColor),
      child: Icon(icon, color: iconColor, size: iconSize),
    );
  }
}
