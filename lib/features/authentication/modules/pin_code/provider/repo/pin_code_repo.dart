import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/authentication/modules/pin_code/provider/api/pin_provider.dart';

class PinCodeRepo {
  PinCodeRepo([PinCodeAPI? api]) {
    _api = api ?? PinCodeAPI();
  }
  late PinCodeAPI _api;
  Future<Either<Failure, bool>> setup(String code, int enableFaceId, int enableFingerprint) async {
    try {
      final Either<Failure, Response<Map<String, dynamic>>> res = await _api.setUpPinCode(
        code,
        enableFaceId,
        enableFingerprint,
      );

      return res.fold((Failure l) => Left<Failure, bool>(l), (Response<Map<String, dynamic>> response) {
        return right(true);
      });
    } on Exception catch (e) {
      return Left<Failure, bool>(ApiFailure(
        errors: <String, String>{'': e.toString()},
        code: 404,
        resourceName: 'Registration_repository_line_39',
      ));
    }
  }
}
