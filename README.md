# Shoe Store — Flutter Clean Architecture Demo

A simple Flutter e-commerce app using the [DummyJSON](https://dummyjson.com) API's
`mens-shoes` and `womens-shoes` categories, built to demonstrate Clean
Architecture, BLoC (with global state), Dependency Injection, and the
Repository Pattern.

## Features
- Product list with local search filtering
- Product detail screen
- Global shopping cart (add, remove, change quantity, checkout)

## Patterns & Where They Live

| Pattern | Location |
|---|---|
| Dependency Injection | `lib/core/di/service_locator.dart` (GetIt) |
| Repository Pattern | `lib/domain/repositories/` (contracts) + `lib/data/repositories/` (implementations) |
| BLoC (Global State) | `lib/presentation/bloc/` — `CartBloc` is provided once at the app root via `MultiBlocProvider` in `main.dart`, so the cart is shared across every screen |
| Clean Architecture | `domain` / `data` / `presentation` layers |

## Project Structure