import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/provider/API/login_api.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/provider/model/login_input.dart';
class LoginRepository {
  late LoginApi _loginApi;

  LoginRepository({LoginApi? loginApi}) {
    _loginApi = loginApi ?? LoginApi.instance;
  }

  LoginRepository._singleTone() {
    _loginApi = LoginApi.instance;
  }

  static final LoginRepository _instance = LoginRepository._singleTone();

  static LoginRepository get instance => _instance;

  Future<Either<Failure, Map<String, dynamic>>> loginRepository(LoginInput loginInput) async {
    try {
      final Either<Failure, Response<dynamic>> res = await _loginApi.loginAPI(loginInput);

      return res.fold((Failure l) => Left<Failure, Map<String, dynamic>>(l), (Response<dynamic> response) {
        return right(response.data as Map<String, dynamic>);
      });
    } on Exception catch (e) {
      return left(ApiFailure(
        errors: <String, String>{'': e.toString()},
        code: 404,
        resourceName: 'ForgetPassword_repository_line_50',
      ));
    }
  }

  Future<Map<String, dynamic>> loginWithResRepository(
      {String? identityId, required String password, String? phoneNumber}) async {
    final Map<String, dynamic> map =
        await _loginApi.loginWitRes(password: password, identityId: identityId, phoneNumber: phoneNumber);
    return map;
  }
}
