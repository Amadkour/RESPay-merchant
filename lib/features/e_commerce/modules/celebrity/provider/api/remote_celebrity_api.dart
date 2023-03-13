import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/api/base_celebrity_api.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/api/end_points.dart';

class RemoteCelebrityApi extends BaseCelebrityApi {
  APIConnection apiConnection = APIConnection.instance;

  RemoteCelebrityApi({APIConnection? apiConnect}) {
    if (apiConnect != null) {
      apiConnection = apiConnect;
    } else {
      apiConnection = APIConnection.instance;
    }
    dio = apiConnection.dio;
  }
  late Dio dio;
  RemoteCelebrityApi.withDio({Dio? dio}) {
    this.dio = dio!;
  }

  RemoteCelebrityApi._singleTone();

  static final RemoteCelebrityApi _instance = RemoteCelebrityApi._singleTone();

  static RemoteCelebrityApi get instance => _instance;

  @override
  Future<Either<Failure, Response<Map<String, dynamic>>>> getAllCelebrities() async {
    try {
      final Response<Map<String, dynamic>> response = await dio.get(getListOfCelebrities);
      final Map<String, dynamic>? body = response.data;
      if (body!['success'] == true) {
        return right(response);
      } else {
        return left(ApiFailure(
          errors: body['errors'] as Map<String, dynamic>,
        ));
      }
    } on SocketException {
      return left(
        NetworkFailure(),
      );
    } on DioError catch (e) {
      return left(ApiFailure(
        errors: <String, String>{'': e.message},
      ));
    }
  }

  @override
  Future<Map<String, dynamic>> getVideos() async {
    final String json = await rootBundle.loadString("assets/jsons/celebrity/video_shop.json");
    return jsonDecode(json) as Map<String, dynamic>;
  }

  @override
  Future<Either<Failure, Response<Map<String, dynamic>>>> getSingleCelebrity({required String celebrityUuid}) async {
    try {
      final Response<Map<String, dynamic>> response = await dio.get(
        getSingleCelebrityEndPoint,
        queryParameters: <String, dynamic>{"celebrity_uuid": celebrityUuid},
      );

      final Map<String, dynamic>? body = response.data;
      if (body!['success'] == true) {
        return right(response);
      } else {
        return left(ApiFailure(
          errors: body['errors'] as Map<String, dynamic>,
        ));
      }
    } on SocketException {
      return left(
        NetworkFailure(),
      );
    } on DioError catch (e) {
      return left(ApiFailure(
        errors: <String, String>{'': e.message},
      ));
    }
  }
}
