import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

@injectable
class GetProducts implements UseCase<List<Product>, bool> {
  final ProductRepository repository;

  GetProducts(this.repository);

  @override
  Future<Either<Failure, List<Product>>> call(bool useCache) async {
    return await repository.getProducts(useCache: useCache);
  }
}
