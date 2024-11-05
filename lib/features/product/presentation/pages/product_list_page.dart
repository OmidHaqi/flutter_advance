import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/product_bloc.dart';
import '../widgets/product_list_item.dart';
import '../../domain/entities/product.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return state.map(
            initial: (_) => const SizedBox.shrink(),
            loading: (_) => const Center(
              child: LinearProgressIndicator(),
            ),
            loaded: (state) => ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) => ProductListItem(
                product: state.products[index],
              ),
            ),
            error: (state) => Center(
              child: Text(state.message),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewProduct(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addNewProduct(BuildContext context) {
    final newProduct = Product(
      id: DateTime.now().toString(),
      name: 'New Product',
      price: 1000000,
      createdAt: DateTime.now(),
    );

    context.read<ProductBloc>().add(ProductEvent.addProduct(newProduct));
  }
}
