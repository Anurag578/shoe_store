import '../repositories/cart_repository.dart';

/// Empties the cart entirely - used after a simulated checkout.
class ClearCartUseCase {
  final CartRepository repository;
  ClearCartUseCase(this.repository);

  void call() => repository.clear();
}
