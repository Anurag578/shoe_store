import '../repositories/cart_repository.dart';

/// Removes a product from the cart entirely.
class RemoveFromCartUseCase {
  final CartRepository repository;
  RemoveFromCartUseCase(this.repository);

  void call(int productId) => repository.removeItem(productId);
}
