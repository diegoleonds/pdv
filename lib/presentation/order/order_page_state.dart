import 'package:equatable/equatable.dart';

class OrderPageState extends Equatable {
  final String formattedTotalPrice;
  final String formattedSubtotalPrice;
  final String formattedTaxPrice;
  final String formattedDiscountPrice;
  final bool isDiscountApplied;

  const OrderPageState({
    this.formattedTotalPrice = "",
    this.formattedSubtotalPrice = "",
    this.formattedTaxPrice = "",
    this.formattedDiscountPrice = "",
    this.isDiscountApplied = false,
  });

  OrderPageState copyWith({
    String? formattedTotalPrice,
    String? formattedSubtotalPrice,
    String? formattedTaxPrice,
    String? formattedDiscountPrice,
    bool? isDiscountApplied,
  }) => OrderPageState(
    formattedTotalPrice: formattedTotalPrice ?? this.formattedTotalPrice,
    formattedSubtotalPrice:
        formattedSubtotalPrice ?? this.formattedSubtotalPrice,
    formattedTaxPrice: formattedTaxPrice ?? this.formattedTaxPrice,
    formattedDiscountPrice:
        formattedDiscountPrice ?? this.formattedDiscountPrice,
    isDiscountApplied: isDiscountApplied ?? this.isDiscountApplied,
  );

  @override
  List<Object?> get props => [
    formattedTotalPrice,
    formattedSubtotalPrice,
    formattedTaxPrice,
    formattedDiscountPrice,
    isDiscountApplied,
  ];
}