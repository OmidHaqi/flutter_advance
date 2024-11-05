import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_data_source.dart';

@Injectable(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource localDataSource;

  ProductRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<Product>>> getProducts(
      {bool useCache = true}) async {
    try {
      final products = useCache
          ? localDataSource.getProductsFromHive()
          : await localDataSource.getProductsFromSQLite();
      return Right(products);
    } catch (e) {
      return Left(Failure.storage(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveProduct(Product product) async {
    try {
      await localDataSource.cacheProducts(product);
      return const Right(unit);
    } catch (e) {
      return Left(Failure.storage(e.toString()));
    }
  }
}
