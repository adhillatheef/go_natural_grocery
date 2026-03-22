import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'api_constants.dart';

class ApiClient {
  late Dio _dio;

  ApiClient() {
    BaseOptions options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    _dio = Dio(options);

    // Adding an interceptor for logging during development
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
      ));
    }
  }

  // Generic POST request method
  Future<Response> post(String endpoint, {Map<String, dynamic>? queryParams, dynamic body}) async {
    try {
      final response = await _dio.post(
        endpoint,
        queryParameters: queryParams,
        data: body,
      );
      return response;
    } on DioException catch (e) {
      // Basic error handling as per requirements
      String errorMessage = "Something went wrong";
      if (e.response != null) {
        errorMessage = e.response?.data['message'] ?? errorMessage;
      } else if (e.type == DioExceptionType.connectionTimeout) {
        errorMessage = "Connection timed out";
      }
      throw Exception(errorMessage);
    }
  }
}