import 'dart:convert'; // For JSON encoding and decoding
import 'package:http/http.dart' as http;
import 'package:point_of_sales/Configuration/AppConfig.dart'; // Import the http package

class ApiService {
  final String baseUrl = AppConfig.apiBaseUrl;

  Future<dynamic> getRequest(String endpoint) async {
    final String url = '$baseUrl$endpoint';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to load data: $error');
    }
  }

  Future<dynamic> postRequest(
      String endpoint, Map<String, dynamic> data) async {
    final String url = '$baseUrl$endpoint';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to post data: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to post data: $error');
    }
  }
}
