import 'package:my_flutter_test/data/datasources/product_remote_data_source.dart';
import 'package:my_flutter_test/domain/repositories/product_repository.dart';
import '../../data/models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ProductModel>> getProducts(int limit, int offset) async {
    return await remoteDataSource.getProducts(limit, offset);
  }
}