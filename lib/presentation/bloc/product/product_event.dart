import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
  @override
  List<Object?> get props => [];
}

/// Fired when the product list screen first opens, or when the search
/// text changes.
class ProductsRequested extends ProductEvent {
  final String query;
  const ProductsRequested({this.query = ''});

  @override
  List<Object?> get props => [query];
}
