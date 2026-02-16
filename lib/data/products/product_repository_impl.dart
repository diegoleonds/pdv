import 'package:drift/drift.dart';
import 'package:pdv/data/database/app_database.dart';
import 'package:pdv/data/products/product_dao.dart';
import 'package:pdv/data/products/product_repository.dart';
import 'package:pdv/domain/entities/product.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDao dao;

  ProductRepositoryImpl(this.dao);

  @override
  Future<List<Products>> getProducts() async => await dao.getProducts();

  @override
  Future insertProducts(List<Product> products) async {
    for (var product in products) {
      dao.insert(
        ProductEntityCompanion(
          name: Value(product.name),
          priceCents: Value(product.priceCents),
        ),
      );
    }
  }
}
