
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/api/base_celebrity_api.dart';


class JsonCelebrityApi extends BaseCelebrityApi {

  @override
  Future<Either<Failure, Response<Map<String, dynamic>>>> getAllCelebrities() async {
    final String json = await rootBundle.loadString("assets/jsons/celebrity/celebrity_list.json");
    try {
      final Map<String, dynamic> response = jsonDecode(json) as Map<String, dynamic>;
      return right(Response<Map<String, dynamic>>(requestOptions: RequestOptions(path: ''),data: response));
    }
    catch (e) {
      return left(ApiFailure(errors: <String,String>{"":"error happen"}));
    }
  }

  @override
  Future<Map<String, dynamic>> getVideos() async {
    final String json = await rootBundle.loadString("assets/jsons/celebrity/video_shop.json");
    return jsonDecode(json) as Map<String, dynamic>;
  }

  @override
  Future<Either<Failure, Response<Map<String, dynamic>>>> getSingleCelebrity({required String celebrityUuid}) {
    // TODO: implement getSingleCelebrity
    throw UnimplementedError();
  }
}
