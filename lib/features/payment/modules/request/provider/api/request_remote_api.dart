import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';
import 'package:res_pay_merchant/features/payment/modules/request/provider/api/end_points.dart';

class RequestRemoteApi {
  APIConnection? apiConnection;

  RequestRemoteApi(this.apiConnection) {
    dio = apiConnection!.dio;
  }

  RequestRemoteApi._singleTone() {
    dio = APIConnection.instance.dio;
  }

  static final RequestRemoteApi _instance = RequestRemoteApi._singleTone();

  static RequestRemoteApi get instance => _instance;
  late Dio dio;
  RequestRemoteApi.withDio({Dio? dio}) {
    this.dio = dio!;
  }

  Future<Either<Failure, Response<Map<String, dynamic>>>>
      getMoneyRequests() async {
    Response<Map<String, dynamic>>? response;
    try {
      APIConnection.instance.showMessage = true;
      response = await dio.get(requestCategoriesList);
      return Right<Failure, Response<Map<String, dynamic>>>(response);
    } catch (e) {
      return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure(
        errors: <String, String>{"": "connection error"},
      ));
    }
  }

  Future<Either<Failure, Response<Map<String, dynamic>>>>
      addNewRequestBeneficiary({required Map<String, dynamic> input}) async {
    Response<Map<String, dynamic>>? response;
    try {
      APIConnection.instance.showMessage = true;
      response = await dio.post(
        createNewRequestBeneficiary,
        data: FormData.fromMap(input),
      );
      return Right<Failure, Response<Map<String, dynamic>>>(response);
    } catch (e) {
      return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure(
        errors: <String, String>{"": "connection error"},
      ));
    }
  }

  Future<Either<Failure, Response<Map<String, dynamic>>>> sendMoney(
      {required Map<String, dynamic> input}) async {
    Response<Map<String, dynamic>>? response;
    APIConnection.instance.showMessage = true;
    try {
      response = await dio.post(moneyRequest, data: FormData.fromMap(input));
      return Right<Failure, Response<Map<String, dynamic>>>(response);
    } catch (e) {
      return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure(
        errors: <String, String>{"": "connection error"},
      ));
    }
  }

  Future<Either<Failure, Response<Map<String, dynamic>>>> acceptOrRejectRequest(
      {required Map<String, dynamic> input}) async {
    Response<Map<String, dynamic>>? response;
    APIConnection.instance.showMessage = true;
    try {
      response = await dio.post(acceptOrRejectRequestEndPoint,
          data: FormData.fromMap(input));
      return Right<Failure, Response<Map<String, dynamic>>>(response);
    } catch (e) {
      return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure(
        errors: <String, String>{"": "connection error"},
      ));
    }
  }
}
