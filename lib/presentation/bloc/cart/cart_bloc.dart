import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/add_to_cart_use_case.dart';
import '../../../domain/usecases/clear_cart_use_case.dart';
import '../../../domain/usecases/get_cart_items_use_case.dart';
import '../../../domain/usecases/remove_from_cart_use_case.dart';
import '../../../domain/usecases/update_cart_quantity_use_case.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartItemsUseCase getCartItemsUseCase;
  final AddToCartUseCase addToCartUseCase;
  final RemoveFromCartUseCase removeFromCartUseCase;
  final UpdateCartQuantityUseCase updateCartQuantityUseCase;
  final ClearCartUseCase clearCartUseCase;

  CartBloc({
    required this.getCartItemsUseCase,
    required this.addToCartUseCase,
    required this.removeFromCartUseCase,
    required this.updateCartQuantityUseCase,
    required this.clearCartUseCase,
  }) : super(const CartState()) {
    on<CartItemAdded>((event, emit) {
      addToCartUseCase(event.product);
      emit(state.copyWith(items: getCartItemsUseCase()));
    });

    on<CartItemRemoved>((event, emit) {
      removeFromCartUseCase(event.productId);
      emit(state.copyWith(items: getCartItemsUseCase()));
    });

    on<CartQuantityChanged>((event, emit) {
      updateCartQuantityUseCase(event.productId, event.quantity);
      emit(state.copyWith(items: getCartItemsUseCase()));
    });

    on<CartCleared>((event, emit) {
      clearCartUseCase();
      emit(state.copyWith(items: getCartItemsUseCase()));
    });
  }
}
