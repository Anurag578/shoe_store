

import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Product>> getProducts({String query = ''}) =>
      remoteDataSource.fetchProducts(query: query);

  @override
  Future<Product> getProductById(int id) =>
      remoteDataSource.fetchProductById(id);
}
