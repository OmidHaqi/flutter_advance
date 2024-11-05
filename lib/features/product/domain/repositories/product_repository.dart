import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts({bool useCache = true});
  Future<Either<Failure, Unit>> saveProduct(Product product);
}
