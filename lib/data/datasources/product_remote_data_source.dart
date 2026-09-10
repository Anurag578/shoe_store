

import '../../domain/entities/product.dart';
import '../../core/network/api_client.dart';

class ProductRemoteDataSource {
  final ApiClient apiClient;
  ProductRemoteDataSource(this.apiClient);

  Future<List<Product>> fetchProducts({String query = ''}) async {
    // Fetch both shoe categories and combine them.
    final mensJson = await apiClient.getJson('/products/category/mens-shoes');
    final womensJson = await apiClient.getJson('/products/category/womens-shoes');

    final mensList = (mensJson['products'] as List<dynamic>? ?? []);
    final womensList = (womensJson['products'] as List<dynamic>? ?? []);

    final allShoes = [...mensList, ...womensList]
        .map((item) => Product.fromJson(item as Map<String, dynamic>))
        .toList();


    if (query.isEmpty) return allShoes;
    return allShoes
        .where((p) => p.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<Product> fetchProductById(int id) async {
    final json = await apiClient.getJson('/products/$id');
    return Product.fromJson(json);
  }
}