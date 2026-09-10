

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../network/api_client.dart';
import '../../data/datasources/product_remote_data_source.dart';
import '../../data/repositories/cart_repository_impl.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/repositories/cart_repository.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/usecases/add_to_cart_use_case.dart';
import '../../domain/usecases/clear_cart_use_case.dart';
import '../../domain/usecases/get_cart_items_use_case.dart';
import '../../domain/usecases/get_product_detail_use_case.dart';
import '../../domain/usecases/get_products_use_case.dart';
import '../../domain/usecases/remove_from_cart_use_case.dart';
import '../../domain/usecases/update_cart_quantity_use_case.dart';
import '../../presentation/bloc/cart/cart_bloc.dart';
import '../../presentation/bloc/product/product_bloc.dart';

final GetIt sl = GetIt.instance;

void setupServiceLocator() {
  // ---- Core / network ----------------------------------------------------
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => ApiClient(sl()));

  // ---- Data layer ---------------------------------------------------------
  sl.registerLazySingleton(() => ProductRemoteDataSource(sl()));
  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(sl()));
  // Registered as a singleton so the SAME in-memory cart list is shared
  // for the whole app session - this is what backs the global cart state.
  sl.registerLazySingleton<CartRepository>(() => CartRepositoryImpl());

  // ---- Domain layer (use cases) --------------------------------------------
  sl.registerLazySingleton(() => GetProductsUseCase(sl()));
  sl.registerLazySingleton(() => GetProductDetailUseCase(sl()));
  sl.registerLazySingleton(() => GetCartItemsUseCase(sl()));
  sl.registerLazySingleton(() => AddToCartUseCase(sl()));
  sl.registerLazySingleton(() => RemoveFromCartUseCase(sl()));
  sl.registerLazySingleton(() => UpdateCartQuantityUseCase(sl()));
  sl.registerLazySingleton(() => ClearCartUseCase(sl()));

  // ---- Presentation layer (Blocs) ------------------------------------------
  sl.registerFactory(() => ProductBloc(getProductsUseCase: sl()));

  // Registered as a singleton because it holds the app's single shared
  // cart state - provided once at the root of the widget tree in main.dart.
  sl.registerLazySingleton(() => CartBloc(
    getCartItemsUseCase: sl(),
    addToCartUseCase: sl(),
    removeFromCartUseCase: sl(),
    updateCartQuantityUseCase: sl(),
    clearCartUseCase: sl(),
  ));
}
