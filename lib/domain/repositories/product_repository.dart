import 'package:my_flutter_test/data/models/product_model.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> getProducts(int limit, int offset);
}