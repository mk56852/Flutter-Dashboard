import 'dart:convert'; // For JSON encoding and decoding
import 'package:http/http.dart' as http;
import 'package:point_of_sales/Configuration/AppConfig.dart';
import 'package:point_of_sales/Models/Category.dart';
import 'package:point_of_sales/Models/Product.dart';
import 'package:point_of_sales/Models/User.dart'; // Import the http package

class ApiService {
  static Future<ApiResponse> getCategories() async {
    dynamic response =
        await http.get(Uri.parse(AppConfig.apiBaseUrl + "api/categories"));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      List<Category> categories =
          jsonResponse.map((category) => Category.fromJson(category)).toList();
      return ApiResponse(status: 200, data: categories);
    }
    return ApiResponse(status: 400, data: []);
  }

  static Future<ApiResponse> updateCategory(updatedcategData, categId) async {
    final response = await http.put(
      Uri.parse(AppConfig.apiBaseUrl + 'api/categories/$categId'),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(updatedcategData),
    );
    if (response.statusCode == 200) {
      return ApiResponse(status: 200, data: []);
    }
    return ApiResponse(status: 400, data: []);
  }

  static Future<ApiResponse> deleteCategory(int id) async {
    final url = Uri.parse(AppConfig.apiBaseUrl + 'api/categories/$id');

    final response = await http.delete(url);

    if (response.statusCode == 200) {
      return ApiResponse(status: 200, data: []);
    } else {
      return ApiResponse(status: 400, data: []);
    }
  }

  static Future<ApiResponse> getUsers() async {
    dynamic response =
        await http.get(Uri.parse(AppConfig.apiBaseUrl + "api/users"));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      List<User> users =
          jsonResponse.map((user) => User.fromJson(user)).toList();
      return ApiResponse(status: 200, data: users);
    }
    return ApiResponse(status: 400, data: []);
  }

  static Future<ApiResponse> updateUser(updatedUserData, userId) async {
    final response = await http.put(
      Uri.parse(AppConfig.apiBaseUrl + 'api/users/$userId'),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(updatedUserData),
    );
    if (response.statusCode == 200) {
      return ApiResponse(status: 200, data: []);
    }
    return ApiResponse(status: 400, data: []);
  }

  static Future<ApiResponse> deleteUser(int id) async {
    final url = Uri.parse(AppConfig.apiBaseUrl + 'api/users/$id');

    final response = await http.delete(url);

    if (response.statusCode == 200) {
      return ApiResponse(status: 200, data: []);
    } else {
      return ApiResponse(status: 400, data: []);
    }
  }

  static Future<ApiResponse> getProducts() async {
    dynamic response =
        await http.get(Uri.parse(AppConfig.apiBaseUrl + "api/products"));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      List<Product> products =
          jsonResponse.map((prod) => Product.fromJson(prod)).toList();
      return ApiResponse(status: 200, data: products);
    }
    return ApiResponse(status: 400, data: []);
  }

  static Future<ApiResponse> updateProduct(
      updatedProductData, productId) async {
    final response = await http.put(
      Uri.parse(AppConfig.apiBaseUrl + 'api/products/$productId'),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(updatedProductData),
    );
    if (response.statusCode == 200) {
      return ApiResponse(status: 200, data: []);
    }
    return ApiResponse(status: 400, data: []);
  }

  static Future<ApiResponse> deleteProduct(int id) async {
    final url = Uri.parse(AppConfig.apiBaseUrl + 'api/products/$id');

    final response = await http.delete(url);

    if (response.statusCode == 200) {
      return ApiResponse(status: 200, data: []);
    } else {
      return ApiResponse(status: 400, data: []);
    }
  }

  static Future<ApiResponse> uploadCategoryImage(
      String fileName, dynamic fileBytes) async {
    final uri = Uri.parse(AppConfig.apiBaseUrl + 'api/upload/category');
    final request = http.MultipartRequest("POST", uri);

    // Add the file as a multipart field
    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        fileBytes,
        filename: fileName,
      ),
    );

    // Send the request
    final response = await request.send();
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final responseData = jsonDecode(responseBody);
      final imageUrl = responseData['url'];
      return ApiResponse(status: 200, data: imageUrl.toString());
    }
    return ApiResponse(status: 400, data: "");
  }

  static Future<ApiResponse> uploadProductImage(
      String fileName, dynamic fileBytes) async {
    final uri = Uri.parse(AppConfig.apiBaseUrl + 'api/upload/product');
    final request = http.MultipartRequest("POST", uri);

    // Add the file as a multipart field
    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        fileBytes,
        filename: fileName,
      ),
    );

    // Send the request
    final response = await request.send();
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final responseData = jsonDecode(responseBody);
      final imageUrl = responseData['url'];
      return ApiResponse(status: 200, data: imageUrl.toString());
    }
    return ApiResponse(status: 400, data: "");
  }
}

class ApiResponse {
  final int status;
  final dynamic data;

  ApiResponse({required this.status, required this.data});
}
