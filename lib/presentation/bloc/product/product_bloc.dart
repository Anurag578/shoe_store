import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_products_use_case.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUseCase getProductsUseCase;

  ProductBloc({required this.getProductsUseCase}) : super(const ProductState()) {
    on<ProductsRequested>(_onProductsRequested);
  }

  Future<void> _onProductsRequested(
      ProductsRequested event, Emitter<ProductState> emit) async {
    emit(state.copyWith(status: ProductStatus.loading));
    try {
      final products = await getProductsUseCase(query: event.query);
      emit(state.copyWith(status: ProductStatus.loaded, products: products));
    } catch (e) {
      emit(state.copyWith(status: ProductStatus.error, errorMessage: e.toString()));
    }
  }
}
