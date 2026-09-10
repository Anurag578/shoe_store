
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  static const String baseUrl = 'https://dummyjson.com';

  final http.Client _client;

  ApiClient(this._client);

  Future<Map<String, dynamic>> getJson(String path) async {
    final response = await _client.get(Uri.parse('$baseUrl$path'));
    if (response.statusCode != 200) {
      throw Exception('API error (${response.statusCode}) for $path');
    }
    return jsonDecode(response.body) as Map<String, dynamic>;
  }
}
