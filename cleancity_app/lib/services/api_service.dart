import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  // Use 10.0.2.2 for Android emulator to access localhost, or actual localhost for web
  static const String baseUrl = 'http://10.0.2.2:5000/api/v1';

  // We are using demo auth token "citizen-123" since DEMO_AUTH_ENABLED=True
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token') ?? 'citizen-123';
  }

  Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<bool> login(String email, String password) async {
    // With demo auth, any token starting with 'citizen-' works
    // For now, just generate a demo token from the email prefix
    final token = 'citizen-${email.split('@')[0]}';
    await setToken(token);
    return true;
  }

  Future<List<Post>> getFeed() async {
    final token = await getToken();
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/reports'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Post.fromJson(json)).toList();
      } else {
        print('Error fetching feed: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      print('Get feed error: $e');
      rethrow;
    }
  }

  Future<bool> createPost(Map<String, dynamic> postData) async {
    final token = await getToken();
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/reports'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(postData),
      );
      
      return response.statusCode == 201;
    } catch (e) {
      print('Create post error: $e');
      return false;
    }
  }
}
