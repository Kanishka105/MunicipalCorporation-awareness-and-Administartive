import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';

class ApiService {
  // Assuming the backend is running on localhost (10.0.2.2 for Android emulator)
  // Update this to your actual backend URL when deploying or testing on a physical device.
  static const String baseUrl = 'http://10.0.2.2:5000/api';

  Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        // Handle token saving here
        return true;
      }
      return false;
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  Future<List<Post>> getFeed() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/posts'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Post.fromJson(json)).toList();
      }
      throw Exception('Failed to load posts');
    } catch (e) {
      print('Get feed error: $e');
      // For demonstration, you might want to fallback to dummy data if backend is offline
      rethrow;
    }
  }

  Future<bool> createPost(Map<String, dynamic> postData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/posts'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(postData),
      );
      
      return response.statusCode == 201;
    } catch (e) {
      print('Create post error: $e');
      return false;
    }
  }
}
