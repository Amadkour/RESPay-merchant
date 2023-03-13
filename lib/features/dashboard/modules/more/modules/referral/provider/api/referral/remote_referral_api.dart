import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:res_pay_merchant/core/constant/shared_orefrences_keys.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/referral/provider/api/referral/end_point.dart';

class RemoteReferralApi{
  APIConnection apiConnection = APIConnection.instance;

  RemoteReferralApi({APIConnection? apiConnect}) {
    if (apiConnect != null) {
      apiConnection = apiConnect;
    } else {
      apiConnection = APIConnection.instance;
    }
  }

  RemoteReferralApi._singleTone();

  static final RemoteReferralApi _instance = RemoteReferralApi._singleTone();

  static RemoteReferralApi get instance => _instance;

  Future<Either<Failure, List<dynamic>>> getUsers() async{
    try{
      final String response = await rootBundle.loadString("assets/jsons/referral/users.json");
      final List<dynamic> json =jsonDecode(response) as List<dynamic>;
      if(json==<dynamic>[]){
        return Left<Failure, List<dynamic>>(ApiFailure(
          errors: <String,String>{"":"error message"},
          code: 404,
          resourceName: 'Referrals_repository_line_39',
        ));
      }
      else {
        return right(json);
      }
    }
    catch(e){
      return Left<Failure, List<dynamic>>(ApiFailure(
        errors: <String,String>{'':e.toString()},
        code: 404,
        resourceName: 'Referrals_repository_line_39',
      ));
    }
  }


  ///----------copy url

  Future<Either<Failure,Response<Map<String,dynamic>>>> copyURL() async {
    apiConnection.showMessage = true;
    Response<Map<String, dynamic>>? response;
    try {
      response = await apiConnection.dio.get(
        referralPath,queryParameters:<String,dynamic>{"user_uuid": userUUID}
      );
      return Right<Failure, Response<Map<String, dynamic>>>(response);
    } catch (e) {
      if (response != null) {
        return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure(
            code: response.statusCode,
            resourceName: 'referral_api_line_74',
            errors: response.data!['errors'] as Map<String, dynamic>));
      } else {
        return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure(
          errors: <String,String>{"":"connection error"},
        ));
      }
    }


  }
}
