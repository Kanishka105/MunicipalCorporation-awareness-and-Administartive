import 'dart:convert';
import 'dart:io' show Platform;
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import '../config.dart';

class ApiService {
  static String get serverHost {
    if (kIsWeb) {
      return 'http://127.0.0.1:5000';
    }
    try {
      if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
        return 'http://127.0.0.1:5000';
      }
      if (Platform.isAndroid) {
        return 'http://10.0.2.2:5000';
      }
    } catch (_) {}
    return 'http://127.0.0.1:5000';
  }

  static String get baseUrl => '$serverHost/api/v1';

  CognitoUserPool get userPool => CognitoUserPool(
    AppConfig.cognitoUserPoolId,
    AppConfig.cognitoClientId,
    clientSecret: AppConfig.cognitoClientSecret.isNotEmpty ? AppConfig.cognitoClientSecret : null,
  );

  String _normalizeMobile(String mobile) {
    String digits = mobile.replaceAll(RegExp(r'\D'), '');
    if (digits.length == 10 && (digits.startsWith('6') || digits.startsWith('7') || digits.startsWith('8') || digits.startsWith('9'))) {
      digits = '91$digits';
    }
    return '+$digits';
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (token != null && token.trim().isNotEmpty) {
      return token.trim();
    }
    return null;
  }

  Future<void> setSession({
    required String token,
    String? idToken,
    String? userId,
    String? mobile,
    String? name,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token.trim());
    if (idToken != null) await prefs.setString('id_token', idToken.trim());
    if (userId != null) await prefs.setString('user_id', userId.trim());
    if (mobile != null) await prefs.setString('mobile', mobile.trim());
    if (name != null) await prefs.setString('user_name', name.trim());
  }

  Future<Map<String, String>> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'user_id': prefs.getString('user_id') ?? '',
      'mobile': prefs.getString('mobile') ?? '',
      'name': prefs.getString('user_name') ?? '',
    };
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('id_token');
    await prefs.remove('user_id');
    await prefs.remove('mobile');
    await prefs.remove('user_name');
  }

  Future<Map<String, dynamic>> login(String mobile, String password) async {
    final formattedMobile = _normalizeMobile(mobile);

    // 1. Try Backend Cognito Authentication Endpoint
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'mobile': formattedMobile,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final accessToken = data['access_token'] ?? '';
        final idToken = data['id_token'] ?? '';

        // Fetch User Info
        String userId = '';
        String name = '';
        try {
          final meRes = await http.get(
            Uri.parse('$baseUrl/auth/me'),
            headers: {'Authorization': 'Bearer $accessToken'},
          );
          if (meRes.statusCode == 200) {
            final meData = jsonDecode(meRes.body);
            userId = meData['user_id'] ?? '';
            name = meData['name'] ?? meData['username'] ?? '';
          }
        } catch (_) {}

        await setSession(
          token: accessToken,
          idToken: idToken,
          userId: userId.isNotEmpty ? userId : formattedMobile,
          mobile: formattedMobile,
          name: name.isNotEmpty ? name : 'Citizen',
        );

        return {'success': true, 'message': 'Logged in successfully'};
      } else {
        final err = jsonDecode(response.body);
        final detail = err['detail'] ?? err['error'] ?? 'Login failed. Please check credentials.';
        return {'success': false, 'message': detail};
      }
    } catch (_) {
      // 2. Direct AWS Cognito SDK Fallback
      try {
        final pool = userPool;
        final cognitoUser = CognitoUser(
          formattedMobile,
          pool,
          clientSecret: AppConfig.cognitoClientSecret.isNotEmpty ? AppConfig.cognitoClientSecret : null,
        );
        final authDetails = AuthenticationDetails(username: formattedMobile, password: password);
        final session = await cognitoUser.authenticateUser(authDetails);
        if (session != null) {
          final accessToken = session.getAccessToken().getJwtToken() ?? '';
          final idToken = session.getIdToken().getJwtToken() ?? '';
          await setSession(
            token: accessToken,
            idToken: idToken,
            userId: formattedMobile,
            mobile: formattedMobile,
            name: 'Citizen',
          );
          return {'success': true, 'message': 'Logged in successfully'};
        }
      } catch (cognitoErr) {
        return {'success': false, 'message': cognitoErr.toString()};
      }
      return {'success': false, 'message': 'Could not connect to authentication service'};
    }
  }

  Future<Map<String, dynamic>> signUp(String mobile, String password, String name) async {
    final formattedMobile = _normalizeMobile(mobile);

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'mobile': formattedMobile,
          'password': password,
          'name': name.trim(),
        }),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Verification code sent via SMS.'};
      } else {
        final err = jsonDecode(response.body);
        final detail = err['detail'] ?? err['error'] ?? 'Sign up failed.';
        return {'success': false, 'message': detail};
      }
    } catch (_) {
      // Direct Cognito fallback
      try {
        final pool = userPool;
        final userAttributes = [
          AttributeArg(name: 'name', value: name.trim()),
          AttributeArg(name: 'phone_number', value: formattedMobile),
        ];
        await pool.signUp(formattedMobile, password, userAttributes: userAttributes);
        return {'success': true, 'message': 'Verification code sent via SMS.'};
      } catch (cogErr) {
        return {'success': false, 'message': cogErr.toString()};
      }
    }
  }

  Future<Map<String, dynamic>> verifyOtp(String mobile, String otp) async {
    final formattedMobile = _normalizeMobile(mobile);

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/confirm'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'mobile': formattedMobile,
          'code': otp.trim(),
        }),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Account confirmed successfully!'};
      } else {
        final err = jsonDecode(response.body);
        final detail = err['detail'] ?? err['error'] ?? 'Confirmation failed.';
        return {'success': false, 'message': detail};
      }
    } catch (_) {
      try {
        final pool = userPool;
        final cognitoUser = CognitoUser(
          formattedMobile,
          pool,
          clientSecret: AppConfig.cognitoClientSecret.isNotEmpty ? AppConfig.cognitoClientSecret : null,
        );
        final confirmed = await cognitoUser.confirmRegistration(otp.trim());
        if (confirmed == true) {
          return {'success': true, 'message': 'Account confirmed successfully!'};
        }
      } catch (cogErr) {
        return {'success': false, 'message': cogErr.toString()};
      }
      return {'success': false, 'message': 'Verification failed.'};
    }
  }

  Future<String?> uploadEvidenceBytes(Uint8List bytes, String filename) async {
    final token = await getToken();
    if (token == null) return null;

    try {
      final uri = Uri.parse('$baseUrl/uploads');
      final request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = 'Bearer $token';

      String extension = filename.split('.').last.toLowerCase();
      if (extension == 'jpg') extension = 'jpeg';
      final mediaType = MediaType('image', extension == 'png' ? 'png' : extension == 'webp' ? 'webp' : 'jpeg');

      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          bytes,
          filename: filename,
          contentType: mediaType,
        ),
      );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return data['photo_url'];
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<bool> createPost(Map<String, dynamic> postData) async {
    final token = await getToken();
    if (token == null) return false;

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
    } catch (_) {
      return false;
    }
  }

  Future<List<Post>> getFeed() async {
    final token = await getToken();
    final user = await getCurrentUser();
    final currentUserId = user['user_id'] ?? '';
    final currentMobile = user['mobile'] ?? '';

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/reports'),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Post.fromJson(json, currentUserId: currentUserId, currentMobile: currentMobile)).toList();
      }
      return [];
    } catch (_) {
      return [];
    }
  }

  Future<List<Post>> getMyPosts() async {
    final token = await getToken();
    final user = await getCurrentUser();
    final currentUserId = user['user_id'] ?? '';
    final currentMobile = user['mobile'] ?? '';

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/reports?mine=true'),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Post.fromJson(json, currentUserId: currentUserId, currentMobile: currentMobile)).toList();
      }
      return [];
    } catch (_) {
      return [];
    }
  }

  Future<Map<String, dynamic>?> upvotePost(String postId) async {
    final token = await getToken();
    if (token == null) return null;

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/reports/$postId/upvote'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}
