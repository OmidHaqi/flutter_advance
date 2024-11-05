// lib/injection.dart
import 'package:flutter_advance/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart' as path;
import './features/product/domain/entities/product.dart';

final getIt = GetIt.instance;

@module
abstract class DatabaseModule {
  @preResolve  
  @singleton
  Future<Database> provideDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      path.join(dbPath, 'products.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE products(
            id TEXT PRIMARY KEY,
            name TEXT,
            price REAL,
            stock INTEGER,
            categories TEXT,
            created_at TEXT
          )
        ''');
      },
    );
  }

  @preResolve
  @singleton
  Future<Box<Product>> provideProductBox() async {
    if (!Hive.isBoxOpen('products')) {
      if (!Hive.isAdapterRegistered(0)) {
        Hive.registerAdapter(ProductAdapter());
      }
      return await Hive.openBox<Product>('products');
    }
    return Hive.box<Product>('products');
  }
}

@InjectableInit(
  initializerName: 'setupDependencies', 
  preferRelativeImports: true, 
  asExtension: false,
)
Future<void> configureDependencies() async => await setupDependencies(getIt);