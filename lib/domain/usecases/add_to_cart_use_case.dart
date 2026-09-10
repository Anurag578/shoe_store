import '../entities/product.dart';
import '../repositories/cart_repository.dart';

/// Adds a product to the cart (or increases its quantity if already there -
/// that increment logic lives in the repository implementation).
class AddToCartUseCase {
  final CartRepository repository;
  AddToCartUseCase(this.repository);

  void call(Product product) => repository.addItem(product);
}
