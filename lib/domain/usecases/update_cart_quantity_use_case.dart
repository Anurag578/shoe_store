import '../repositories/cart_repository.dart';


class UpdateCartQuantityUseCase {
  final CartRepository repository;
  UpdateCartQuantityUseCase(this.repository);

  void call(int productId, int quantity) =>
      repository.updateQuantity(productId, quantity);
}
