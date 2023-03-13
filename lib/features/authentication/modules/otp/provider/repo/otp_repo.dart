import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/authentication/modules/otp/provider/api/otp_provider.dart';

class OtpRepo {
  OtpRepo([OtpApi? api]) {
    _api = api ?? OtpApi.instance;
  }
  late OtpApi _api;
  Future<Either<Failure, String>> verify(Map<String, dynamic> verificationType) async {
    try {
      final Either<Failure, Response<Map<String, dynamic>>> res = await _api.sendOTP(verificationType);
      return res.fold((Failure l) => Left<Failure, String>(l), (Response<Map<String, dynamic>> response) {
        return Right<Failure, String>(response.data!['message'].toString());
      });
    } on Exception catch (e) {
      return Left<Failure, String>(ApiFailure(
        errors: <String, String>{'': e.toString()},
        code: 404,
        resourceName: 'Registration_repository_line_39',
      ));
    }
  }
}
