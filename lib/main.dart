

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/service_locator.dart';
import 'presentation/bloc/cart/cart_bloc.dart';
import 'presentation/bloc/product/product_bloc.dart';
import 'presentation/pages/product_list_page.dart';

void main() {
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(create: (_) => sl<ProductBloc>()),
        // CartBloc is a singleton in the DI container AND provided once
        // here - together these two facts are what make its state global.
        BlocProvider<CartBloc>(create: (_) => sl<CartBloc>()),
      ],
      child: MaterialApp(
        title: 'Shoe Store',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          useMaterial3: true,
        ),
        home: const ProductListPage(),
      ),
    );
  }
}
