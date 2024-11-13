import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:prophub/src/utilities/storage/app_storage.dart';

class AppInterceptor extends Interceptor {
  AppInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    AppStorage storage = AppStorage();
    String token = await storage.getAuthTokenVal();
    if (token.isNotEmpty) {
      options.headers.addAll({
        'Authorization': 'Bearer ${await storage.getAuthTokenVal()}',
      });
    }
    options.headers.addAll({
      'X-CHANNEL': 'PROP_HUB_APP',
    });
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      response.statusCode = 200;
    } else if (response.statusCode == 401) {}
    return super.onResponse(response, handler);
  }
}

class RefreshTokenInterceptor extends Interceptor {
  RefreshTokenInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    AppStorage storage = AppStorage();
    String token = await storage.getAuthTokenVal();
    if (token.isNotEmpty) {
      options.headers.addAll({
        'Authorization': 'Bearer ${await storage.getRefreshTokenVal()}',
      });
    }
    options.headers.addAll({
      'X-CHANNEL': 'PROP_HUB_APP',
    });
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      response.statusCode = 200;
    } else if (response.statusCode == 401) {}
    return super.onResponse(response, handler);
  }
}

class SignActivityInterceptor extends Interceptor {
  SignActivityInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers.addAll({
      'X-CHANNEL': 'PROP_HUB_APP',
    });
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      response.statusCode = 200;
    } else if (response.statusCode == 401) {}
    return super.onResponse(response, handler);
  }
}

/// This function used for those devices which does not support
/// newer ssl certificate and disabled in web
void fixBadCertificate({required Dio dio}) {
  if (!kIsWeb) {
    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient(context: SecurityContext(withTrustedRoots: false));

        client.badCertificateCallback = (cert, host, post) => true;
        return client;
      },
      validateCertificate: (cert, host, port) => true,
    );
  }
}
