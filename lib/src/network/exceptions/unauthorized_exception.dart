import 'package:prophub/src/exceptions/ground_exception.dart';

class UnauthorizedException extends PropHubExceptions {
  const UnauthorizedException({
    this.statusCode,
    this.messagePrompt,
    this.timestamp,
    this.status,
    this.errorCode,
    this.reference,
    this.additionalInfo,
  });

  final int? statusCode;
  final String? messagePrompt;
  final DateTime? timestamp;
  final String? status;
  final String? errorCode;
  final String? reference;
  final Map? additionalInfo;

  factory UnauthorizedException.fromJson(Map<String, dynamic> json) => UnauthorizedException(
    statusCode: json["statusCode"] ?? 0,
    messagePrompt: json["message"] ?? '',
    timestamp: json['timestamp'] == null ? null : DateTime.tryParse(json['timestamp'] as String),
    status: json["status"] ?? '',
    errorCode: json["errorCode"] ?? '',
    reference: json["reference"] ?? '',
    additionalInfo: json["additionalInfo"],
  );

  @override
  String get message => messagePrompt ?? super.message;
}