import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prophub/src/exceptions/ground_exception.dart';

import '../utilities/data_transformer.dart';
import 'exceptions/exceptions.dart';

const bool _showLogs = kDebugMode;

class AppNetworkProvider {
  int retries = 0;

  Dio _getDioInstance() {
    var dio = Dio(BaseOptions(
        connectTimeout: const Duration(milliseconds: 30000), receiveTimeout: const Duration(milliseconds: 60000)));
    // dio.interceptors.add(AppInterceptor());
    dio.interceptors.add(QueuedInterceptorsWrapper(onError: (error, handler) async {
      if (error.response?.statusCode == 401) {
        if (retries == 1) return handler.next(error);
        retries++;
        try {
          // await refreshToken();
          handler.resolve(await _retry(error.requestOptions));
        } on PropHubExceptions {
          handler.next(error);
        }
        return;
      }
      handler.next(error);
    }));

    if (_showLogs) {
      dio.interceptors.add(LogInterceptor(
          responseBody: _showLogs,
          error: _showLogs,
          request: _showLogs,
          requestBody: _showLogs,
          requestHeader: _showLogs,
          responseHeader: _showLogs));
    }

    return dio;
  }

  Dio _genericDioInstance() {
    var dio = Dio(BaseOptions(
        connectTimeout: const Duration(milliseconds: 30000), receiveTimeout: const Duration(milliseconds: 60000)));

    if (_showLogs) {
      dio.interceptors.add(LogInterceptor(
          responseBody: _showLogs,
          error: _showLogs,
          request: _showLogs,
          requestBody: _showLogs,
          requestHeader: _showLogs,
          responseHeader: _showLogs));
    }

    return dio;
  }

  // Future<void> refreshToken() async {
  //   Response? response;
  //   AkuStorage akuStorage = AkuStorage();
  //   var dio = Dio()
  //     ..interceptors.add(LogInterceptor(
  //       responseBody: _showLogs,
  //       error: _showLogs,
  //       request: _showLogs,
  //       requestBody: _showLogs,
  //       requestHeader: _showLogs,
  //       responseHeader: _showLogs,
  //     ));
  //   final Uri apiUrl = Uri.parse(ApiConfig.getRefreshToken);
  //   try {
  //     response = await dio.getUri(apiUrl);
  //     if (response.statusCode == 200) {
  //       retries = 0;
  //       final data = LoginSuccessResponse.fromJson(response.data);
  //       await Future.wait([
  //         akuStorage.setAuthToken(data.accessToken),
  //         akuStorage.setRefreshToken(data.refreshToken),
  //       ]);
  //     }
  //   } on DioException catch (e) {
  //     final error = transformObject(e, ((p0) => ResponseException.fromDio(p0)));
  //     if (error.isLeft) throw error.left;
  //     throw error.right;
  //   } on Exception catch (e) {
  //     throw GroundException(e.toString());
  //   }
  // }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return _getDioInstance().request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  Dio _getSignActivityDioInstance() {
    var dio = Dio(BaseOptions(
        connectTimeout: const Duration(milliseconds: 30000), receiveTimeout: const Duration(milliseconds: 30000)));
    // dio.interceptors.add(SignActivityInterceptor());
    if (_showLogs) {
      dio.interceptors.add(LogInterceptor(
        responseBody: _showLogs,
        error: _showLogs,
        request: _showLogs,
        requestBody: _showLogs,
        requestHeader: _showLogs,
        responseHeader: _showLogs,
      ));
    }

    return dio;
  }

  final Ref ref;

  AppNetworkProvider({required this.ref});

  Future<Either<PropHubExceptions, Response?>> call(
      {required String path,
      required RequestMethod method,
      dynamic body = const {},
      Map<String, dynamic> queryParams = const {},
      Options? options}) async {
    Response? response;
    try {
      final dioInstance = _getDioInstance();
      response = await switch (method) {
        RequestMethod.get => dioInstance.get(path, queryParameters: queryParams),
        RequestMethod.post => dioInstance.post(path, data: body, queryParameters: queryParams, options: options),
        RequestMethod.patch => dioInstance.patch(path, data: body, queryParameters: queryParams),
        RequestMethod.put => dioInstance.put(path, data: body, queryParameters: queryParams),
        RequestMethod.delete => dioInstance.delete(path, data: body, queryParameters: queryParams),
      };
      retries = 0;
      return Right(response);
    } on DioException catch (e) {
      retries = 0;
      final error = transformObject(e, ((p0) => ResponseException.fromDio(p0)));
      if (error.isLeft) {
        return Left(error.left);
      }
      return Left(error.right);
    } on Exception catch (e) {
      return Left(GroundException(e.toString()));
    }
  }

  Future<Response<dynamic>> generic(RequestOptions requestOptions) async {
    final options = Options(method: requestOptions.method, headers: requestOptions.headers);
    return _genericDioInstance().request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}

enum RequestMethod { get, post, put, patch, delete }
