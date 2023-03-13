import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';

abstract class BaseAnalyticsApi {
  Future<Either<Failure, Response<Map<String, dynamic>>>> get();
}
