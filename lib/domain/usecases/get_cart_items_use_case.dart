import '../entities/cart_item.dart';
import '../repositories/cart_repository.dart';

/// Reads the current contents of the cart.
class GetCartItemsUseCase {
  final CartRepository repository;
  GetCartItemsUseCase(this.repository);

  List<CartItem> call() => repository.getItems();
}
