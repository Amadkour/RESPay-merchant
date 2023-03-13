import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';
import 'package:res_pay_merchant/features/payment/modules/gift/provider/api/end_points.dart';

class GiftRemoteApi {
  APIConnection? apiConnection;
  late Dio dio;

  GiftRemoteApi(this.apiConnection) {
    dio = apiConnection!.dio;
  }

  GiftRemoteApi._singleTone() {
    dio = APIConnection.instance.dio;
    apiConnection = APIConnection.instance;
  }

  static final GiftRemoteApi _instance = GiftRemoteApi._singleTone();

  static GiftRemoteApi get instance => _instance;

  GiftRemoteApi.withDio({Dio? dio}) {
    this.dio = dio!;
    apiConnection = APIConnection.instance;
  }

  Future<Either<Failure, Response<Map<String, dynamic>>>> sendGift(
      {required Map<String, dynamic> input}) async {
    apiConnection!.showMessage = true;
    Response<Map<String, dynamic>>? response;
    try {
      response = await dio.post(
        data: FormData.fromMap(input),
        giftRequest,
      );
      return Right<Failure, Response<Map<String, dynamic>>>(response);
    } catch (e) {
      return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure(
        errors: <String, String>{"": "server error"},
      ));
    }
  }

  Future<Either<Failure, Response<Map<String, dynamic>>>> addNewGiftBeneficiary(
      {required Map<String, dynamic> input}) async {
    apiConnection!.showMessage = true;
    Response<Map<String, dynamic>>? response;
    try {
      response = await dio.post(
        createNewGiftBeneficiary,
        data: FormData.fromMap(input),
      );
      return Right<Failure, Response<Map<String, dynamic>>>(response);
    } catch (e) {
      return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure(
        errors: <String, String>{"": "server error"},
      ));
    }
  }

  Future<Either<Failure, Response<Map<String, dynamic>>>>
      getReceivedGifts() async {
    apiConnection!.showMessage = true;
    Response<Map<String, dynamic>>? response;
    try {
      response = await dio.get(getGiftsPath);
      return Right<Failure, Response<Map<String, dynamic>>>(response);
    } catch (e) {
      return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure(
        errors: <String, String>{"": "server error"},
      ));
    }
  }
}
