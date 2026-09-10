

import '../../domain/entities/cart_item.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final List<CartItem> _items = [];

  @override
  List<CartItem> getItems() => List.unmodifiable(_items);

  @override
  void addItem(Product product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index == -1) {
      _items.add(CartItem(product: product, quantity: 1));
    } else {
      _items[index] = _items[index].copyWith(quantity: _items[index].quantity + 1);
    }
  }

  @override
  void removeItem(int productId) {
    _items.removeWhere((item) => item.product.id == productId);
  }

  @override
  void updateQuantity(int productId, int quantity) {
    if (quantity <= 0) {
      removeItem(productId);
      return;
    }
    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index != -1) {
      _items[index] = _items[index].copyWith(quantity: quantity);
    }
  }

  @override
  void clear() => _items.clear();
}
