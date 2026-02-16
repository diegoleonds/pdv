import 'package:drift/drift.dart';
import '../database/app_database.dart';
import '../entities/product_entity.dart';

@DriftAccessor(tables: [ProductEntity])
class ProductDao extends DatabaseAccessor<AppDatabase> {
  ProductDao(super.db);

  Future<List<Products>> getProducts() => select(db.productEntity).get();

  Future<int> insert(ProductEntityCompanion product) =>
      into(db.productEntity).insert(product);
}
