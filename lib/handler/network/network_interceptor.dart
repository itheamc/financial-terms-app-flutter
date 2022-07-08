import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'network_response.dart';

///--------------------------------@mit------------------------------
/// Custom Network Interceptor Class to Handle the errors
class NetworkInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final success = (response.statusCode ?? 0) ~/ 200 == 1;
    if (success) {
      return handler.next(
        SuccessResponse(
          data: response.data,
          requestOptions: response.requestOptions,
          headers: response.headers,
          isRedirect: response.isRedirect,
          statusCode: response.statusCode,
          statusMessage: "Data fetched successfully!!",
          redirects: response.redirects,
          extra: response.extra,
        ),
      );
    } else {
      if (kDebugMode) {
        print("[_____ERROR___onResponse]------>${response.data}");
      }
      return handler.next(
        FailureResponse(
          data: response.data,
          requestOptions: response.requestOptions,
          headers: response.headers,
          isRedirect: response.isRedirect,
          statusCode: response.statusCode,
          statusMessage: "Request Failed",
          redirects: response.redirects,
          extra: response.extra,
        ),
      );
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      print("[___ERROR___onError] -------> ${err.message}}");
    }
    switch (err.type) {
      case DioErrorType.connectTimeout:
        return handler.resolve(
          ErrorResponse(
              requestOptions: err.requestOptions,
              statusMessage: "Connection timeout with server"),
        );
      case DioErrorType.receiveTimeout:
        return handler.resolve(
          ErrorResponse(
              requestOptions: err.requestOptions,
              statusMessage: "Response timeout with server"),
        );
      case DioErrorType.sendTimeout:
        return handler.resolve(
          ErrorResponse(
              requestOptions: err.requestOptions,
              statusMessage: "Send timeout with server"),
        );
      case DioErrorType.response:
        if (kDebugMode) {
          print(err.response?.data);
        }
        return handler.resolve(
          FailureResponse(
            data: err.response?.data,
            requestOptions: err.requestOptions,
            headers: err.response?.headers,
            isRedirect: err.response?.isRedirect,
            statusCode: err.response?.statusCode,
            statusMessage: "Request Failed",
            redirects: err.response?.redirects,
            extra: err.response?.extra,
          ),
        );
      case DioErrorType.cancel:
        return handler.resolve(
          ErrorResponse(
              requestOptions: err.requestOptions,
              statusMessage: "Request is cancelled"),
        );
      default:
        return handler.resolve(
          ErrorResponse(
              requestOptions: err.requestOptions,
              statusMessage: "Something went wrong"),
        );
    }
  }
}