import 'dart:io';

import 'package:bhavapp/core/network/Base/Network%20Manager/ApiRequest.dart';
import 'package:bhavapp/core/network/Base/Network%20Manager/ApiTaskCode.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import '../../../../shared/common.dart';
import '../../../../shared/shared_pref_manager.dart';
import 'BaseResponse.dart';
import 'ResponseParser.dart';

enum ApiType { get, put, update, delete, patch, post }

class ApiManager {
  final Dio _dio;
  static final ApiManager _instance = ApiManager._internal();

  factory ApiManager() => _instance;

  ApiManager._internal() : _dio = Dio() {
    // _dio.interceptors.add(LogInterceptor(responseBody: true));
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          printValue("Request APIUrl : ${options.uri} ---- ${options.method}");
          /* bool isLoggedIn = await SharedPrefManager.instance.isLoggedIn();
          if (isLoggedIn) {
            String? token = await SharedPrefManager.instance.getAccessToken();
            options.headers["Authorization"] = token;
          }*/
          printValue("Request APIHeaders----${options.headers}");
          printValue("Request APIBody----${options.data}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          printValue("Response code----${response.statusCode}");
          printValue(response.data);
          if (response?.statusCode == 401) {
            /* UtilsCommon().signOut();
            UtilsCommon.showToastSnackbar(
                title: "Alert",
                msg: 'Session expired, Please login again...',
                type: ToastType.warning);*/
            return;
          }
          return handler.next(response);
        },
        onError: (error, handler) {
          printValue(
            "Error APIUrl : ${error.requestOptions.uri} ---- ${error.requestOptions.method}",
          );
          printValue("Error APIBody----${error.requestOptions.data}");
          printValue("Error----${error.message}");
          printValue("Error code----${error.response?.statusCode}");
          printValue("Error data----");
          printValue(error.response?.data);
          if (error.response?.statusCode == 401) {
            /*UtilsCommon().signOut();
            UtilsCommon.showToastSnackbar(
                title: "Alert",
                msg: 'Session expired, Please login again...',
                type: ToastType.warning);*/
            return;
          }
          return handler.next(error);
        },
      ),
    );
  }

  void _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode == 400) {
          throw Exception("Bad request");
        } else if (statusCode == 401) {
          throw Exception("Token expired. Please login again.");
        } else {
          throw Exception("Unexpected error: $statusCode");
        }
      case DioExceptionType.connectionError:
        throw Exception("Connection error");
      case DioExceptionType.connectionTimeout:
        throw Exception("Connection timeout");
      default:
        throw Exception("Something went wrong");
    }
  }
}

extension ApiManagerExtension on ApiManager {
  Future<ApiResponse<T>?> makeRequest<T>({
    required ApiRequest request,
    required ApiTaskCode taskcode,
  }) async {
    try {
      var responseBody;
      Response response;
      if (request.method == ApiType.get) {
        response = await _dio.get(
          request.endpoint,
          queryParameters: request.query,
          options: Options(headers: request.headers),
        );
        responseBody = response.data;
      } else if (request.method == ApiType.post) {
        response = await _dio.post(
          request.endpoint,
          data: request.body,
          options: Options(headers: request.headers),
        );
        responseBody = response.data;
      } else if (request.method == ApiType.put) {
        response = await _dio.put(
          request.endpoint,
          data: request.body,
          options: Options(headers: request.headers),
        );
        responseBody = response.data;
      } else if (request.method == ApiType.delete) {
        response = await _dio.delete(
          request.endpoint,
          data: request.body,
          options: Options(headers: request.headers),
        );
        responseBody = response.data;
      } else if (request.method == ApiType.patch) {
        response = await _dio.patch(
          request.endpoint,
          data: request.body,
          options: Options(headers: request.headers),
        );
        responseBody = response.data;
      } else {
        throw Exception("Invalid API type");
      }

      final bodyMap =
          (responseBody is Map<String, dynamic>)
              ? responseBody
              : <String, dynamic>{};

      final int statusCode = response.statusCode ?? 0;
      final String? responseStatus =
          (bodyMap['ResponseStatus'] ?? bodyMap['Status'])
              ?.toString()
              .toLowerCase();
      final bool isSuccessStatus = statusCode == 200 || statusCode == 201;
      final bool hasData =
          bodyMap.containsKey('Data') && bodyMap['Data'] != null;

      if (isSuccessStatus && (responseStatus == 'success' || hasData)) {
        final parsedData = TaskParserRegistry.parse<T>(
          taskcode,
          bodyMap['Data'],
        );
        return ApiResponse<T>.fromJson(bodyMap, (_) => parsedData);
      } else {
        return ApiResponse<T>.fromJson(bodyMap, (_) => null as T);
      }
    } on DioException catch (e) {
      if (e.response != null && e.response?.data is Map<String, dynamic>) {
        final responseBody = e.response!.data as Map<String, dynamic>;
        return ApiResponse<T>.fromJson(responseBody, (_) => null as T);
      }

      // Log and handle unexpected Dio error
      _handleDioError(e);
      return null;
    }
  }
}

// Add this to pubspec.yaml if not already

extension UploadExtension on ApiManager {
  Future<ApiResponse<T>?> uploadRequest<T>({
    required ApiRequest request,
    required ApiTaskCode taskcode,
    required File file,
    required String filedKey,
  }) async {
    try {
      final body = Map<String, dynamic>.from(request.body ?? {});
      final filePath = file.path;
      final fileName = filePath.split('/').last;
      // ✅ Detect MIME type
      final mimeType = lookupMimeType(filePath);

      final multipartFile = await MultipartFile.fromFile(
        filePath,
        filename: fileName,
        contentType: mimeType != null ? MediaType.parse(mimeType) : null,
      );

      final formData = FormData.fromMap({...body, filedKey: multipartFile});

      request.headers?["Content-Type"] = 'multipart/form-data';
      final response = await _dio.post(
        request.endpoint,
        data: formData,
        options: Options(headers: request.headers),
      );

      final responseBody = response.data;
      if (response.statusCode == 200 && responseBody['Status'] == 'Success') {
        final parsedData = TaskParserRegistry.parse<T>(
          taskcode,
          responseBody['Data'],
        );
        return ApiResponse<T>.fromJson(responseBody, (_) => parsedData);
      } else {
        // Fail case - still return a valid ApiResponse with null data
        return ApiResponse<T>.fromJson(responseBody, (_) => null as T);
      }
    } on DioException catch (e) {
      if (e.response != null && e.response?.data is Map<String, dynamic>) {
        final responseBody = e.response!.data as Map<String, dynamic>;
        return ApiResponse<T>.fromJson(responseBody, (_) => null as T);
      }

      // Log and handle unexpected Dio error
      _handleDioError(e);
      return null;
    }
  }
}
