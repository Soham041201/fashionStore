import 'package:ecommerce/models/product.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class ProductDatabase {
  static final ProductDatabase instance = ProductDatabase._init();

  Database? _database;

  ProductDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('products.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = dbPath + filePath;

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute(
        "CREATE TABLE PRODUCTS( id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, price INTEGER NOT NULL,description TEXT NOT NULL, category TEXT NOT NULL, image TEXT NOT NULL)");
  }

  Future<Product> create(Product product) async {
    final db = await instance.database;
    final id = await db.insert('PRODUCTS', product.toMap());
    if (kDebugMode) print(id);
    return product;
  }

  Future addAll(List<Product> products) async {
    final db = await instance.database;

    await Future.wait(products.map((element) async {
      int id = await db.insert('PRODUCTS', element.toMap());
      if (kDebugMode) print(id);
    }));
  }

  Future updateAll(List<Product> products) async {
    final db = await instance.database;
    await Future.wait(products.map((element) async {
      int id = await db.update('PRODUCTS', element.toMap());
      if (kDebugMode) print(id);
    }));
  }

  Future<List<Product>> readAllProducts() async {
    final db = await instance.database;
    final result = await db.query('PRODUCTS');
    return result.map((json) => Product.fromMap(json)).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
