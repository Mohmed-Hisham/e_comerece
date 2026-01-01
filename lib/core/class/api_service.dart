import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:e_comerece/core/funcations/checkinternet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  ApiService._internal() {
    _initDio();
  }
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;

  final Dio _dio = Dio();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  final _defaultHeaders = {'Content-Type': 'application/json'};

  void _initDio() {
    _dio.options = BaseOptions(
      connectTimeout: const Duration(minutes: 2),
      sendTimeout: const Duration(minutes: 2),
      receiveTimeout: const Duration(minutes: 2),
      headers: _defaultHeaders,
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          try {
            final token = await _storage.read(key: 'token');
            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          } catch (e) {
            log('Error reading token in interceptor: $e');
          }
          return handler.next(options);
        },
        onError: (error, handler) {
          return handler.next(error);
        },
      ),
    );
  }

  Future<Response> post({
    required String endPoints,
    Object? data,
    Map<String, String>? extraHeaders,
    CancelToken? cancelToken,
  }) async {
    if (!await checkInternet()) {
      throw Exception('No internet connection');
    }
    final headers = Map<String, dynamic>.from(_defaultHeaders);
    if (extraHeaders != null) headers.addAll(extraHeaders);

    try {
      final response = await _dio.post(
        endPoints,
        data: data,
        options: Options(headers: headers),
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> get({
    required String endpoint,
    Map<String, String>? extraHeaders,
    CancelToken? cancelToken,
  }) async {
    if (!await checkInternet()) {
      throw Exception('No internet connection');
    }
    final headers = Map<String, dynamic>.from(_defaultHeaders);
    if (extraHeaders != null) headers.addAll(extraHeaders);

    final response = await _dio.get(
      endpoint,
      options: Options(headers: headers),
      cancelToken: cancelToken,
    );
    return response.data as Map<String, dynamic>;
  }

  Future<Response> delete({
    required String endPoints,
    Map<String, String>? extraHeaders,
  }) async {
    if (!await checkInternet()) {
      throw Exception('No internet connection');
    }
    final headers = Map<String, dynamic>.from(_defaultHeaders);
    if (extraHeaders != null) headers.addAll(extraHeaders);
    try {
      var response = await _dio.delete(
        endPoints,
        options: Options(method: 'DELETE', headers: headers),
      );
      return response;
    } catch (error) {
      debugPrint('Delete error: $error');
      rethrow;
    }
  }

  Future<Response> put({
    required String endPoints,
    required Map<String, dynamic> data,
    Map<String, String>? extraHeaders,
  }) async {
    if (!await checkInternet()) {
      throw Exception('No internet connection');
    }
    final headers = Map<String, dynamic>.from(_defaultHeaders);
    if (extraHeaders != null) headers.addAll(extraHeaders);
    try {
      var response = await _dio.put(
        endPoints,
        data: data,
        options: Options(method: 'PUT', headers: headers),
      );
      return response;
    } catch (error) {
      debugPrint('Put error: $error');
      rethrow;
    }
  }
}
