import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdv/data/entities/order_status.dart';
import 'package:pdv/domain/entities/payment_method.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../entities/cart_item_entity.dart';
import '../entities/order_entity.dart';
import '../entities/product_entity.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [ProductEntity, OrderEntity, CartItemEntity])
class AppDatabase extends _$AppDatabase {
  AppDatabase._internal() : super(_openConnection());

  static final AppDatabase _instance = AppDatabase._internal();

  factory AppDatabase() => _instance;

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'my_database',
      native: DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        await _prepopulateDatabase();
      },
    );
  }

  Future<void> _prepopulateDatabase() async {
    final jsonString = await rootBundle.loadString('assets/seed.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    final List<dynamic> jsonData = jsonMap['products'];

    await batch((batch) {
      batch.insertAll(
        productEntity,
        jsonData.map(
          (item) => ProductEntityCompanion.insert(
            name: item['name'],
            priceCents: item['priceCents'],
          ),
        ),
      );
    });
  }
}