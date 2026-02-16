import '../../domain/entities/product.dart';
import '../database/app_database.dart';

abstract class ProductRepository {
  Future<List<Products>> getProducts();
  Future insertProducts(List<Product> products);
}
