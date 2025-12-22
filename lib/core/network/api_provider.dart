// lib/core/network/api_provider.dart
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  static const String baseUrl = 'https://yourapi.com/api';
  static const Duration timeout = Duration(seconds: 20);

  static Future<dynamic> get(String endpoint, {Map<String, String>? headers}) async {
    final Uri url = Uri.parse('$baseUrl$endpoint');

    try {
      final response = await http.get(url, headers: headers).timeout(timeout);
      return _handleResponse(response);
    } on SocketException {
      _showError("No internet connection");
    } on HttpException {
      _showError("Couldn't find the data");
    } on FormatException {
      _showError("Bad response format");
    } on TimeoutException {
      _showError("Request timed out");
    } catch (e) {
      _showError("Something went wrong");
    }
    return null;
  }

  static Future<dynamic> post(String endpoint, Map<String, dynamic> body,
      {Map<String, String>? headers}) async {
    final Uri url = Uri.parse('$baseUrl$endpoint');

    try {
      final response = await http
          .post(url, headers: headers, body: jsonEncode(body))
          .timeout(timeout);
      return _handleResponse(response);
    } on SocketException {
      _showError("No internet connection");
    } on HttpException {
      _showError("Couldn't find the data");
    } on FormatException {
      _showError("Bad response format");
    } on TimeoutException {
      _showError("Request timed out");
    } catch (e) {
      _showError("Something went wrong");
    }
    return null;
  }

  static dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      _showError("Error ${response.statusCode}: ${response.reasonPhrase}");
      return null;
    }
  }

  static void _showError(String message) {
    Get.snackbar(
      "Error",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade600,
      colorText: Colors.white,
    );
  }
}
