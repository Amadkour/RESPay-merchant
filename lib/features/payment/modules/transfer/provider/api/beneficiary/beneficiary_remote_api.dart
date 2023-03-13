import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/api/end_point.dart';

class BeneficiaryRemoteApi {
  APIConnection? apiConnection;
  late Dio dio;

  BeneficiaryRemoteApi(this.apiConnection) {
    dio = apiConnection!.dio;
  }

  BeneficiaryRemoteApi._singleTone() {
    dio = APIConnection.instance.dio;
  }

  static final BeneficiaryRemoteApi _instance =
      BeneficiaryRemoteApi._singleTone();

  static BeneficiaryRemoteApi get instance => _instance;

  BeneficiaryRemoteApi.withDio({Dio? dio}) {
    this.dio = dio!;
  }

  Future<Either<Failure, Response<Map<String, dynamic>>>>
      createTransferBeneficiary({required Map<String, dynamic> inputs}) async {
    Response<Map<String, dynamic>>? response;
    try {
      response =
          await dio.post(createNewBeneficiary, data: FormData.fromMap(inputs));
      return Right<Failure, Response<Map<String, dynamic>>>(response);
    } catch (e) {
      return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure(
        errors: <String, String>{"": "server error"},
      ));
    }
  }

  Future<Either<Failure, Response<Map<String, dynamic>>>> getBeneficiaries(
      {String? method}) async {
    APIConnection.instance.showMessage = true;
    Response<Map<String, dynamic>>? response;
    try {
      response = await dio.get(loadBeneficiaries,
          queryParameters: method != null
              ? <String, dynamic>{
                  "method": method,
                }
              : <String, dynamic>{});
      return Right<Failure, Response<Map<String, dynamic>>>(response);
    } catch (e) {
      return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure(
        errors: <String, String>{"": "server error"},
      ));
    }
  }

  Future<Either<Failure, Response<Map<String, dynamic>>>> favouriteToggle(
      {String? beneficiaryUUiD}) async {
    APIConnection.instance.showMessage = true;
    Response<Map<String, dynamic>>? response;
    try {
      response = await dio
          .post(favouriteToggleEndPoint, queryParameters: <String, dynamic>{
        "beneficiary_uuid": beneficiaryUUiD,
      });
      return Right<Failure, Response<Map<String, dynamic>>>(response);
    } catch (e) {
      return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure(
        errors: <String, String>{"": "server error"},
      ));
    }
  }

  Future<Either<Failure, Response<Map<String, dynamic>>>> deleteBeneficiery({required String uuid}) async {
    try {
      final Response<Map<String, dynamic>> response = await dio.post(
        data: FormData.fromMap(<String,dynamic>{
          "beneficiary_uuid":uuid,
        }
        ),
        '/beneficiaries/delete',
      );

      final Map<String, dynamic>? body = response.data;

      if (body?['success'] == true) {
        return right(response);
      } else {
        return left(ApiFailure(
          errors: body?['errors'] as Map<String, dynamic>,
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
