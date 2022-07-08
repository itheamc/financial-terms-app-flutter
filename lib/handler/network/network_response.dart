import 'package:dio/dio.dart';

///---------------------------------@amit----------------------------------
/// Class For Network Response
class NetworkResponse {
  final Response _response;

  ResponseType get responseType => _response is SuccessResponse
      ? ResponseType.success
      : _response is FailureResponse
      ? ResponseType.failure
      : ResponseType.error;

  String get message => _response.statusMessage ?? "Something went Wrong!!";

  bool get isSuccess => responseType == ResponseType.success;

  dynamic get data => _response.data['terms'];

  int? get statusCode => _response.statusCode;

  bool get hasData => data != null;

  NetworkResponse(
      this._response,
      );
}

///---------------------------------@mit----------------------------------
/// Success Network Response
class SuccessResponse extends Response {
  SuccessResponse({
    required super.requestOptions,
    super.data,
    super.headers,
    super.isRedirect,
    super.statusCode,
    super.statusMessage,
    super.redirects,
    super.extra,
  });
}

///---------------------------------@mit----------------------------------
/// Failure Network Response
class FailureResponse extends Response {
  FailureResponse({
    required super.requestOptions,
    super.data,
    super.headers,
    super.isRedirect,
    super.statusCode,
    super.statusMessage,
    super.redirects,
    super.extra,
  });
}

///---------------------------------@mit----------------------------------
/// Error Network Response
class ErrorResponse extends Response {
  ErrorResponse({
    required super.requestOptions,
    super.data,
    super.headers,
    super.isRedirect,
    super.statusCode,
    super.statusMessage,
    super.redirects,
    super.extra,
  });
}

///---------------------------------@mit----------------------------------
/// Network Response Type
enum ResponseType { success, failure, error }

///---------------------------------@mit----------------------------------
/// Network Request Status
enum NetworkRequestStatus { none, requesting, completed }

///---------------------------------@mit----------------------------------
/// Extension Function
extension ResponseExtension on Response {
  NetworkResponse toNetworkResponse() {
    return NetworkResponse(this);
  }
}