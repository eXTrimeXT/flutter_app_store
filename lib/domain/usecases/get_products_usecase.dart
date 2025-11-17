import 'package:my_flutter_test/data/models/product_model.dart';
import 'package:my_flutter_test/domain/repositories/product_repository.dart';

class GetProductsUseCase {
  final ProductRepository repository;

  GetProductsUseCase({required this.repository});

  Future<List<ProductModel>> call(int limit, int offset) async {
    return await repository.getProducts(limit, offset);
  }
}