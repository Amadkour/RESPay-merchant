import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/authentication/modules/forget_password/provider/Api/forget_password_api.dart';

class ForgetPasswordRepository {
  late ForgotPasswordAPI _forgotPasswordAPI;

  /// ------------------------ Pass [ForgotPasswordAPI] To use it in testing ------------------------ ///
  ForgetPasswordRepository({ForgotPasswordAPI? forgotPasswordAPI}) {
    _forgotPasswordAPI = forgotPasswordAPI ?? ForgotPasswordAPI.instance;
  }

  /// --------------------------- SingleTone Repository ------------------------ ///
  ForgetPasswordRepository._singleTone() {
    _forgotPasswordAPI = ForgotPasswordAPI.instance;
  }

  static final ForgetPasswordRepository _instance = ForgetPasswordRepository._singleTone();

  static ForgetPasswordRepository get instance => _instance;

  Future<Either<Failure, String>> forgotPasswordRepository(
      {required Map<String, String> identifier}) async {
    try {
      /// --------------------------- Calling API Function ------------------------ ///
      final Either<Failure, Response<dynamic>> res =
          await _forgotPasswordAPI.forgotPassword(identifier: identifier);

      return res.fold((Failure l) => Left<Failure, String>(l), (Response<dynamic> response) {
        if (response.statusCode != 200 ||
            !((response.data as Map<String, dynamic>?)!['success'] as bool)) {
          /// Failure Response
          return Left<Failure, String>(ApiFailure(

              code: response.statusCode,
              resourceName: 'Registration_repository_line_35',
              errors:
                  ((response.data as Map<String, dynamic>?)!['errors'] as Map<String, dynamic>?) ??
                      <String, String>{}));
        } else {
          /// Success
          return Right<Failure, String>(
              ((response.data as Map<String, dynamic>?)!['data'] as Map<String, dynamic>)['otp']
                  .toString());
        }
      });
    } on Exception catch (e) {
      /// Repository Crashed
      return Left<Failure, String>(ApiFailure(
        errors: <String,String>{'':e.toString()},
        code: 404,
        resourceName: 'ForgetPassword_repository_line_50',
      ));
    }
  }


}
