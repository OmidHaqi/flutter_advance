import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_products.dart';
import '../../domain/usecases/save_product.dart';

part 'product_event.dart';
part 'product_state.dart';
part 'product_bloc.freezed.dart';

@injectable
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProducts;
  final SaveProduct saveProduct;

  ProductBloc({
    required this.getProducts,
    required this.saveProduct,
  }) : super(const ProductState.initial()) {
    on<ProductEvent>((event, emit) async {
      await event.map(
        fetchProducts: (e) async {
          emit(const ProductState.loading());

          // Await the asynchronous result
          final result = await getProducts(e.useCache);

          // Make sure both callbacks in `fold` are async
          await result.fold(
            (failure) async {
              if (!emit.isDone) {
                emit(ProductState.error(failure.toString()));
              }
            },
            (products) async {
              if (!emit.isDone) {
                emit(ProductState.loaded(products));
              }
            },
          );
        },
        addProduct: (e) async {
          emit(const ProductState.loading());

          // Await the asynchronous result
          final result = await saveProduct(e.product);

          // Make sure both callbacks in `fold` are async
          await result.fold(
            (failure) async {
              if (!emit.isDone) {
                emit(ProductState.error(failure.toString()));
              }
            },
            (_) async {
              // Fetch products again and await the result
              final productsResult = await getProducts(true);

              // Make sure both callbacks in `fold` are async
              await productsResult.fold(
                (failure) async {
                  if (!emit.isDone) {
                    emit(ProductState.error(failure.toString()));
                  }
                },
                (products) async {
                  if (!emit.isDone) {
                    emit(ProductState.loaded(products));
                  }
                },
              );
            },
          );
        },
      );
    });
  }
}
