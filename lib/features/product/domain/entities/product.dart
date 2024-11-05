import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
@HiveType(typeId: 0)
class Product with _$Product {
  const factory Product({
    @HiveField(0)
    required String id,
    
    @HiveField(1)
    required String name,
    
    @HiveField(2)
    required int price,
    
    @HiveField(3)
    @Default(0)
    int stock,
    
    @HiveField(4)
    @Default([])
    List<String> categories,
    
    @HiveField(5)
    required DateTime createdAt,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  
}
