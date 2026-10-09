import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class CivicPulseSession {
  static String? accessToken;
}

class CivicPulseApi {
  CivicPulseApi({http.Client? client})
      : _client = client ?? http.Client(),
        _baseUrl = const String.fromEnvironment(
          'CIVICPULSE_API_BASE_URL',
          defaultValue: 'http://localhost:8000',
        );

  final http.Client _client;
  final String _baseUrl;

  Map<String, String> get _headers {
    final token = CivicPulseSession.accessToken;
    if (token == null || token.trim().isEmpty) {
      throw StateError('Sign in with a valid CivicPulse access token to continue.');
    }
    return {
      'Authorization': 'Bearer ${token.trim()}',
      'Content-Type': 'application/json',
    };
  }

  Future<List<Map<String, dynamic>>> listReports() async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/api/v1/reports'),
      headers: _headers,
    );
    final body = _decodeResponse(response);
    if (body is! List) {
      throw const FormatException('The reports API returned an invalid response.');
    }
    return body.cast<Map<String, dynamic>>();
  }

  Future<Map<String, dynamic>> createReport(Map<String, dynamic> report) async {
    final response = await _client.post(
      Uri.parse('$_baseUrl/api/v1/reports'),
      headers: _headers,
      body: jsonEncode(report),
    );
    final body = _decodeResponse(response);
    if (body is! Map<String, dynamic>) {
      throw const FormatException('The reports API returned an invalid response.');
    }
    return body;
  }

  Future<Map<String, dynamic>> uploadEvidence(XFile image) async {
    final mimeType = _imageMimeType(image);
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$_baseUrl/api/v1/uploads'),
    );
    request.headers['Authorization'] = _headers['Authorization']!;
    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        await image.readAsBytes(),
        filename: image.name,
        contentType: MediaType.parse(mimeType),
      ),
    );
    final streamedResponse = await _client.send(request);
    final response = await http.Response.fromStream(streamedResponse);
    final body = _decodeResponse(response);
    if (body is! Map<String, dynamic> || body['photo_url'] is! String) {
      throw const FormatException('The upload API returned an invalid evidence reference.');
    }
    return body;
  }

  String _imageMimeType(XFile image) {
    final mimeType = image.mimeType?.toLowerCase();
    if (mimeType == 'image/jpeg' || mimeType == 'image/png' || mimeType == 'image/webp') {
      return mimeType!;
    }
    final extension = image.name.toLowerCase().split('.').last;
    return switch (extension) {
      'jpg' || 'jpeg' => 'image/jpeg',
      'png' => 'image/png',
      'webp' => 'image/webp',
      _ => throw FormatException(
          'Unsupported image type. Select a JPEG, PNG, or WebP image.',
        ),
    };
  }

  dynamic _decodeResponse(http.Response response) {
    final dynamic body;
    try {
      body = jsonDecode(response.body);
    } on FormatException {
      throw FormatException('The CivicPulse API returned invalid JSON (${response.statusCode}).');
    }
    if (response.statusCode < 200 || response.statusCode >= 300) {
      final message = body is Map<String, dynamic>
          ? body['error']?.toString() ?? body['detail']?.toString()
          : null;
      throw Exception(message ?? 'CivicPulse API request failed (${response.statusCode}).');
    }
    return body;
  }
}
