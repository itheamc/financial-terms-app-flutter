import 'dart:io';

import 'package:dio/dio.dart';
import 'package:financial_terms/handler/network/api_urls.dart';

import 'network_interceptor.dart';
import 'network_response.dart';

///--------------------------------@mit------------------------------
/// RequestHandler class to handle network requests
class RequestHandler {
  static _defaultHeaders(contentType) => {
        HttpHeaders.contentTypeHeader: contentType,
      };

  static Future<NetworkResponse> get(
    String endpoint, {
    bool authenticate = true,
    Map<String, dynamic>? extraHeaders,
    Map<String, dynamic>? defaultHeaders,
    String contentType = "application/json",
    bool forceRefresh = false,
  }) async {
    try {
      Map<String, dynamic> headers =
          defaultHeaders ?? _defaultHeaders(contentType);

      if (extraHeaders != null) {
        headers.addAll(extraHeaders);
      }

      var dio = Dio(
        BaseOptions(baseUrl: ApiUrls.base, headers: headers),
      )..interceptors.add(NetworkInterceptor());

      var res = await dio.get(endpoint);
      return res.toNetworkResponse();
    } catch (e) {
      return NetworkResponse(ErrorResponse(
          requestOptions: RequestOptions(path: endpoint),
          statusMessage: "Something went wrong!!"));
    }
  }
}
