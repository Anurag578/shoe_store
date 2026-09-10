import 'package:equatable/equatable.dart';
import '../../../domain/entities/product.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
  @override
  List<Object?> get props => [];
}

class CartItemAdded extends CartEvent {
  final Product product;
  const CartItemAdded(this.product);
  @override
  List<Object?> get props => [product.id];
}

class CartItemRemoved extends CartEvent {
  final int productId;
  const CartItemRemoved(this.productId);
  @override
  List<Object?> get props => [productId];
}

class CartQuantityChanged extends CartEvent {
  final int productId;
  final int quantity;
  const CartQuantityChanged(this.productId, this.quantity);
  @override
  List<Object?> get props => [productId, quantity];
}

class CartCleared extends CartEvent {}
