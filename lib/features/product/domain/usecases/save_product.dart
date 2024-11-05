import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

@injectable
class SaveProduct implements UseCase<Unit, Product> {
  final ProductRepository repository;

  SaveProduct(this.repository);

  @override
  Future<Either<Failure, Unit>> call(Product product) async {
    return await repository.saveProduct(product);
  }
}
