import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import '../config.dart';

class ApiService {
  static String get baseUrl {
    if (const bool.fromEnvironment('dart.library.html')) {
      return 'http://127.0.0.1:5000/api/v1'; // Web
    }
    return 'http://10.0.2.2:5000/api/v1'; // Android
  }

  final userPool = CognitoUserPool(
    AppConfig.cognitoRegion + '_' + AppConfig.cognitoUserPoolId.split('_').last,
    AppConfig.cognitoClientId,
    clientSecret: AppConfig.cognitoClientSecret,
  );

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<bool> login(String mobile, String password) async {
    final cognitoUser = CognitoUser(mobile, userPool);
    final authDetails = AuthenticationDetails(username: mobile, password: password);
    try {
      final session = await cognitoUser.authenticateUser(authDetails);
      if (session != null) {
        await setToken(session.getIdToken().getJwtToken() ?? '');
        return true;
      }
    } catch (e) {
      print('Login error: $e');
    }
    return false;
  }

  Future<bool> signUp(String mobile, String password, String name) async {
    try {
      final userAttributes = [
        AttributeArg(name: 'name', value: name),
        AttributeArg(name: 'phone_number', value: mobile),
      ];
      await userPool.signUp(mobile, password, userAttributes: userAttributes);
      return true;
    } catch (e) {
      print('Signup error: $e');
      return false;
    }
  }

  Future<bool> verifyOtp(String mobile, String otp) async {
    final cognitoUser = CognitoUser(mobile, userPool);
    try {
      return await cognitoUser.confirmRegistration(otp);
    } catch (e) {
      print('OTP verify error: $e');
      return false;
    }
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
