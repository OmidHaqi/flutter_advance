part of 'product_bloc.dart';

@freezed
class ProductEvent with _$ProductEvent {
  const factory ProductEvent.fetchProducts({@Default(true) bool useCache}) =
      _FetchProducts;
  const factory ProductEvent.addProduct(Product product) = _AddProduct;
}
