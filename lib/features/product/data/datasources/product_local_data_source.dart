import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
import '../../domain/entities/product.dart';

abstract class ProductLocalDataSource {
  Future<List<Product>> getProductsFromSQLite();
  List<Product> getProductsFromHive();
  Future<void> cacheProducts(Product product);
}

@Injectable(as: ProductLocalDataSource)
class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final Database database;
  final Box<Product> productBox;

  ProductLocalDataSourceImpl({
    required this.database,
    required this.productBox,
  });

  @override
  Future<List<Product>> getProductsFromSQLite() async {
    final List<Map<String, dynamic>> maps = await database.query('products');

    return maps
        .map((map) => Product(
              id: map['id'],
              name: map['name'],
              price: map['price'],
              stock: map['stock'],
              categories: (map['categories'] as String).split(','),
              createdAt: DateTime.parse(map['created_at']),
            ))
        .toList();
  }

  @override
  List<Product> getProductsFromHive() {
    return productBox.values.toList();
  }

  @override
  Future<void> cacheProducts(Product product) async {
    await database.insert(
      'products',
      {
        'id': product.id,
        'name': product.name,
        'price': product.price,
        'stock': product.stock,
        'categories': product.categories.join(','),
        'created_at': product.createdAt.toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // Save to Hive
    await productBox.put(product.id, product);
  }
}
