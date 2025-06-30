import 'package:prophub/src/exceptions/ground_exception.dart';
import 'package:dio/dio.dart';
import 'package:prophub/src/network/exceptions/unauthorized_exception.dart';

class ResponseException extends PropHubExceptions {
  final int? statusCode;
  final String? errorMessage;
  final DateTime? timeStamp;
  final String? status;
  final String? errorCode;
  final String? reference;

  const ResponseException({
    this.statusCode,
    this.errorCode,
    this.errorMessage,
    this.timeStamp,
    this.status,
    this.reference,
  });

  factory ResponseException.fromDio(Object dioError) => _handleCallErrors(dioError);

  factory ResponseException.fromJson(Map json) => ResponseException(
        statusCode: json['statusCode'],
        errorMessage: json['message'],
        timeStamp: DateTime.tryParse((json['timeStamp'] as String?) ?? DateTime.now().toString()),
        status: json['status'],
        errorCode: json['errorCode'],
        reference: json['reference'],
      );

  static ResponseException _handleCallErrors(Object error) {
    late final ResponseException exception;
    if (error is DioException) {
      var dioError = error;
      switch (dioError.type) {
        case DioExceptionType.cancel:
          exception = const ResponseException(errorMessage: "Request was cancelled");
          break;
        case DioExceptionType.connectionTimeout:
          exception = const ResponseException(errorMessage: "Connection timeout");
          break;
        case DioExceptionType.unknown:
          exception = const ResponseException(errorMessage: "Connection failed due to internet connection");
          break;
        case DioExceptionType.receiveTimeout:
          exception = const ResponseException(errorMessage: "Receive timeout in connection");
          break;
        case DioExceptionType.badResponse:
          if (dioError.response?.statusCode == 401) UnauthorizedException.fromJson(dioError.response!.data);
          if (dioError.response?.statusCode == 402) throw dioError.response!.data; // PaymentRequiredException.fromJson(dioError.response!.data);
          if (dioError.response?.statusCode == 405) {
            throw const ResponseException(errorMessage: 'An Error Occurred. We\'re working to fix it');
          }
          if (dioError.response?.statusCode == 412) throw dioError.response!.data; // KycVerificationException.fromJson(dioError.response!.data);
          if (dioError.response?.statusCode == 418) {
            throw dioError.response!.data; // TransactionProcessingException.fromJson(dioError.response!.data);
          }
          if (dioError.response?.statusCode == 428) throw dioError.response!.data; // AuthRequiredException.fromJson(dioError.response!.data);
          if ((dioError.response?.statusCode ?? 400) >= 500) {
            throw ResponseException(errorMessage: dioError.response?.statusMessage ?? 'An Error Occurred. We\'re working to fix it');
          }
          exception = ResponseException.fromJson(dioError.response!.data);
          break;
        case DioExceptionType.sendTimeout:
          exception = const ResponseException(errorMessage: "Send timeout in connection");
          break;
        case DioExceptionType.badCertificate:
          exception = const ResponseException(errorMessage: "Bad Certificate");
          break;
        case DioExceptionType.connectionError:
          exception = const ResponseException(errorMessage: "Connection error");
          break;
      }
    } else {
      exception = const ResponseException(errorMessage: "An unexpected error occurred");
    }

    return exception;
  }

  String get _errorMessage {
    if (statusCode == 401) return 'Session Timeout';
    return errorMessage ?? super.message;
  }

  @override
  String get message => _errorMessage;

  List<Object?> get props => [
        statusCode,
        errorMessage,
        timeStamp,
        status,
        errorCode,
        reference,
      ];
}
