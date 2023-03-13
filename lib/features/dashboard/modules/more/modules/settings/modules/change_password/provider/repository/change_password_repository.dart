import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/settings/modules/change_password/provider/API/change_password_api.dart';

class ChangePasswordRepository {
  late ChangePasswordAPI _changePasswordAPI;

  /// ------------------------ Pass [ChangePasswordAPI] To use it in testing ------------------------ ///
  ChangePasswordRepository({ChangePasswordAPI? forgotPasswordAPI}) {
    _changePasswordAPI = forgotPasswordAPI ?? ChangePasswordAPI.instance;
  }

  /// --------------------------- SingleTone Repository ------------------------ ///
  ChangePasswordRepository._singleTone() {
    _changePasswordAPI = ChangePasswordAPI.instance;
  }

  static final ChangePasswordRepository _instance =
      ChangePasswordRepository._singleTone();

  static ChangePasswordRepository get instance => _instance;

  /// Change Password Repository
  Future<Either<Failure, String>> changePasswordRepository({
    required String? oldPassword,
    required String? newPassword,
    required String? newPasswordConfirmation,
  }) async {
    try {
      /// --------------------------- Calling API Function ------------------------ ///
      final Either<Failure, Response<dynamic>> res =
          await _changePasswordAPI.changePassword(
              oldPassword: oldPassword!,
              newPassword: newPassword!,
              newPasswordConfirmation: newPasswordConfirmation!);

      return res.fold((Failure l) => Left<Failure, String>(l),
          (Response<dynamic> response) {
        if (response.statusCode != 200 ||
            !((response.data as Map<String, dynamic>?)!['success'] as bool)) {
          /// Failure Response
          return Left<Failure, String>(ApiFailure(

              code: response.statusCode,
              resourceName: 'Registration_repository_line_35',
              errors: ((response.data as Map<String, dynamic>?)!['errors']
                      as Map<String, dynamic>?) ??
                  <String, String>{}));
        } else {
          /// Success
          return Right<Failure, String>(
              ((response.data as Map<String, dynamic>?)!['data']
                      as Map<String, dynamic>)['otp']
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
