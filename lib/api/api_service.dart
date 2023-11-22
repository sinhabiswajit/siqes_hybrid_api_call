import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl;

  ApiService(this.apiUrl);

  Future<List<Map<String, dynamic>>> fetchQuotes() async {
    // Check for network connectivity
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      throw Exception('No Internet Connection');
    }

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> results = data['results'] ?? [];
        return results.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load quotes');
      }
    } catch (e) {
      throw Exception('Error loading quotes: $e');
    }
  }
}
