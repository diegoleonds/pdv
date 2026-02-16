
import 'package:drift/drift.dart';

@DataClassName('Products')
class ProductEntity extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get priceCents => integer()();
}
