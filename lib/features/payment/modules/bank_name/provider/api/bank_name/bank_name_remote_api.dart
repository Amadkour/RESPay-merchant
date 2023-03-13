import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';
import 'package:res_pay_merchant/features/payment/modules/bank_name/provider/api/end_point.dart';
class BankNameRemoteApi{

  APIConnection ?apiConnection;
  late Dio dio;

  BankNameRemoteApi(this.apiConnection){
    dio=apiConnection!.dio;
  }

  BankNameRemoteApi._singleTone() {
    dio = APIConnection.instance.dio;
    apiConnection=APIConnection.instance;
  }

  static final BankNameRemoteApi _instance = BankNameRemoteApi._singleTone();

  static BankNameRemoteApi get instance => _instance;

  BankNameRemoteApi.withDio({Dio? dio}) {
    this.dio = dio!;
    apiConnection=APIConnection.instance;
  }

  Future<Either<Failure,Response<Map<String,dynamic>>>> getAllBankNames() async {
    APIConnection.instance.showMessage = true;


    Response<Map<String,dynamic>> ?response;
    try {
      response = await dio.get(loadBankNames,);
      return Right<Failure,Response<Map<String,dynamic>>>(response);
    }  catch (e) {
      if(response!=null){
        return Left<Failure,Response<Map<String,dynamic>>>(ApiFailure(
            code: response.statusCode,
            resourceName: 'Beneficiary_api_line_90',
            errors: response.data!['errors'] as Map<String,dynamic>
        ));
      }
      else{
        return Left<Failure,Response<Map<String,dynamic>>>(ApiFailure(
            errors: <String,String>{"":"connection error"},
        ));
      }
    }
  }
}
