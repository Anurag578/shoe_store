
import '../entities/cart_item.dart';
import '../entities/product.dart';

abstract class CartRepository {
  List<CartItem> getItems();
  void addItem(Product product);
  void removeItem(int productId);
  void updateQuantity(int productId, int quantity);
  void clear();
}
