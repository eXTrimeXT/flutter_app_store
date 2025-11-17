import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_flutter_test/presentation/pages/products/viewmodels/product_view_model.dart';
import 'package:my_flutter_test/presentation/pages/products/widgets/product_card.dart';
import 'package:my_flutter_test/presentation/pages/products/widgets/product_shimmer.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final viewModel = context.read<ProductViewModel>();
    viewModel.loadProducts();

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final viewModel = context.read<ProductViewModel>();
      viewModel.loadProducts();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<ProductViewModel>().refresh();
            },
          ),
        ],
      ),
      body: Consumer<ProductViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.products.isEmpty && viewModel.isLoading) {
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) => const ProductShimmer(),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              viewModel.refresh();
            },
            child: ListView.builder(
              controller: _scrollController,
              itemCount: viewModel.products.length + (viewModel.hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == viewModel.products.length) {
                  return viewModel.hasMore
                      ? const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                      : const SizedBox();
                }

                final product = viewModel.products[index];
                return ProductCard(product: product);
              },
            ),
          );
        },
      ),
    );
  }
}