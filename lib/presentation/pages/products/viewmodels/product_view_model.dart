import 'package:flutter/material.dart';
import 'package:my_flutter_test/data/models/product_model.dart';
import 'package:my_flutter_test/domain/usecases/get_products_usecase.dart';

class ProductViewModel with ChangeNotifier {
  final GetProductsUseCase getProductsUseCase;

  ProductViewModel({required this.getProductsUseCase});

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _hasMore = true;
  bool get hasMore => _hasMore;

  int _currentPage = 0;
  final int _limit = 10;

  Future<void> loadProducts() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    notifyListeners();

    try {
      final newProducts = await getProductsUseCase(
        _limit,
        _currentPage * _limit,
      );

      if (newProducts.isEmpty) {
        _hasMore = false;
      } else {
        _products.addAll(newProducts);
        _currentPage++;
      }
    } catch (e) {
      // Handle error
      print('Error loading products: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void refresh() {
    _products.clear();
    _currentPage = 0;
    _hasMore = true;
    loadProducts();
  }
}