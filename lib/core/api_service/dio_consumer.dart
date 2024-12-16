// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dio/dio.dart';
import 'package:locum_app/core/Errors/exception.dart';
import 'package:locum_app/core/api_service/api_consumer.dart';
import 'package:locum_app/core/api_service/api_interceptors.dart';
import 'package:locum_app/core/api_service/check_internet.dart';
import 'package:locum_app/core/api_service/end_points.dart';
import 'package:locum_app/core/heleprs/print_helper.dart';
import 'package:locum_app/features/auth/helpers/auth_helpers.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = EndPoint.baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 60);
    dio.options.receiveTimeout = const Duration(seconds: 60);

    dio.interceptors
        .add(DioInterceptor()); // i use the interceptor to add the header
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
  }

  @override
  Future get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameter,
  }) async {
    try {
      pr(AuthHelpers.getCachedToken(), 'Token in DioConsumer');
      dio.options.headers = {
        "Authorization": 'Bearer ${AuthHelpers.getCachedToken()}',
        "Accept": "application/json"
      };
      if (!(await checkInternet())) {
        throw OfflineException();
      }
      final response = await dio.get(
        path,
        data: data,
        queryParameters: queryParameter,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameter,
    bool isFormData = false,
  }) async {
    pr(AuthHelpers.getCachedToken(), 'Token in DioConsumer');
    dio.options.headers = {
      "Authorization": 'Bearer ${AuthHelpers.getCachedToken()}',
      "Accept": "application/json"
    };
    try {
      if (!(await checkInternet())) {
        throw OfflineException();
      }
      final response = await dio.delete(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameter,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameter,
    bool isFormData = false,
  }) async {
    pr(AuthHelpers.getCachedToken(), 'Token in DioConsumer');
    dio.options.headers = {
      "Authorization": 'Bearer ${AuthHelpers.getCachedToken()}',
      "Accept": "application/json"
    };
    try {
      if (!(await checkInternet())) {
        throw OfflineException();
      }
      final response = await dio.patch(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameter,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameter,
    bool isFormData = false,
  }) async {
    pr(AuthHelpers.getCachedToken(), 'Token in DioConsumer');
    dio.options.headers = {
      "Authorization": 'Bearer ${AuthHelpers.getCachedToken()}',
      "Accept": "application/json"
    };
    try {
      if (!(await checkInternet())) {
        throw OfflineException();
      }
      final response = await dio.post(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameter,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
