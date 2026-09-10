import '../entities/product.dart';
import '../repositories/product_repository.dart';

/// Fetches a single product's full details by id.
class GetProductDetailUseCase {
  final ProductRepository repository;
  GetProductDetailUseCase(this.repository);

  Future<Product> call(int id) => repository.getProductById(id);
}
