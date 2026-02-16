import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final int priceCents;

  const Product({required this.id, required this.name, required this.priceCents});

  @override
  List<Object?> get props => [id, name, priceCents];
}
