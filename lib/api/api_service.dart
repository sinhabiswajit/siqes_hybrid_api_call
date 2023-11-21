import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl;

  ApiService(this.apiUrl);

  Future<List<Map<String, dynamic>>> fetchQuotes() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'] ?? [];
      return results.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load quotes');
    }
  }
}