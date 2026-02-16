import 'package:pdv/data/database/app_database.dart';
import 'package:pdv/domain/entities/product.dart';

extension ProductsMapper on Products {
  Product toDomain() => Product(
    id: id,
    name: name,
    priceCents: priceCents,
  );
}