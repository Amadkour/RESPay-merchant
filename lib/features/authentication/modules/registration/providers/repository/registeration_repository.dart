import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/authentication/modules/registration/providers/Api/registration_api.dart';
import 'package:res_pay_merchant/features/authentication/modules/registration/providers/models/register_inputs.dart';
class RegistrationRepository {
  late RegistrationAPI _api;

  RegistrationRepository([RegistrationAPI? api]) {
    _api = api ?? RegistrationAPI.instance;
  }
  Future<Either<Failure, String>> register(RegisterInputs inputs) async {
    try {
      final Either<Failure, Response<Map<String, dynamic>>> res = await _api.registration(inputs);
      return res.fold((Failure l) {
        return left(l);
      }, (Response<Map<String, dynamic>> response) {
        return right((response.data!['data'] as Map<String, dynamic>)['otp'].toString());
      });
    } on Exception catch (e) {
      return left(ApiFailure(
        errors: <String, String>{'': e.toString()},
        code: 404,
        resourceName: 'Registration_repository_line_39',
      ));
    }
  }
}
