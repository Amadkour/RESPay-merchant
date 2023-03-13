import 'package:dio/dio.dart';

class ValueClass {
  final FormData? successfulBody;
  final FormData? failureBody;
  final Map<String, dynamic>? successfulParams;
  final Map<String, dynamic>? failureParams;
  final Map<String, dynamic>? successfulHeader;
  final Map<String, dynamic>? failureHeader;
  final Map<String, dynamic> successfulResponse;
  final Map<String, dynamic> failureResponse;
  final String path;

  ValueClass({
    required this.path,
    required this.successfulResponse,
    required this.failureResponse,
    this.successfulBody,
    this.failureBody,
    this.successfulParams,
    this.failureParams,
    this.successfulHeader,
    this.failureHeader,
  });
}
