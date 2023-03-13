import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';

abstract class BaseCelebrityApi {
  Future<Either<Failure, Response<Map<String, dynamic>>>> getAllCelebrities();
  Future<Either<Failure, Response<Map<String, dynamic>>>> getSingleCelebrity({required String celebrityUuid});
  Future<Map<String, dynamic>> getVideos();
}
