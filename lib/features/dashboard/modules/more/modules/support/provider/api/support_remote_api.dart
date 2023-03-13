import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/support/provider/end_points.dart';

class SupportRemoteApi{

  APIConnection ?apiConnection;


  SupportRemoteApi(this.apiConnection){
    dio=apiConnection!.dio;
  }

  SupportRemoteApi._singleTone() {
    dio = APIConnection.instance.dio;
  }

  static final SupportRemoteApi _instance = SupportRemoteApi._singleTone();

  static SupportRemoteApi get instance => _instance;
  late Dio dio;
  SupportRemoteApi.withDio({Dio? dio}) {
    this.dio = dio!;
  }

  Future<Either<Failure, Response<Map<String, dynamic>>>> sendSupportRequest({required Map<String, dynamic> input}) async {
    APIConnection.instance.showMessage = true;
    Response<Map<String,dynamic>>? response;
    try {
      response = await dio.post(data: input, support,);
      return Right<Failure, Response<Map<String, dynamic>>>(response);
    } catch (e) {
      return Left<Failure,Response<Map<String,dynamic>>>(ApiFailure(
        errors:<String,String> {"":"connection error"},
      ));
    }
  }
}
