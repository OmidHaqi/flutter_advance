import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';

class ProductListItem extends StatelessWidget {
  final Product product;

  const ProductListItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(product.name),
        subtitle: Text('${product.price} Toman'),
        trailing: Text('Balance: ${product.stock}'),
      ),
    );
  }
}