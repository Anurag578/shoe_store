import '../entities/product.dart';
import '../repositories/product_repository.dart';

/// Fetches the product list, optionally filtered by a search query.
class GetProductsUseCase {
  final ProductRepository repository;
  GetProductsUseCase(this.repository);

  Future<List<Product>> call({String query = ''}) =>
      repository.getProducts(query: query);
}
