import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/authentication/modules/forget_password/provider/Api/create_new_password_api.dart';

class CreateNewPasswordRepository {
  late CreateNewPasswordAPI _createNewPasswordAPI;

  /// ------------------------ Pass [CreateNewPasswordAPI] To use it in testing ------------------------ ///
  CreateNewPasswordRepository({CreateNewPasswordAPI? createNewPasswordAPI}) {
    _createNewPasswordAPI =
        createNewPasswordAPI ?? CreateNewPasswordAPI.instance;
  }

  /// --------------------------- SingleTone Repository ------------------------ ///
  CreateNewPasswordRepository._singleTone() {
    _createNewPasswordAPI = CreateNewPasswordAPI.instance;
  }

  static final CreateNewPasswordRepository _instance =
      CreateNewPasswordRepository._singleTone();

  static CreateNewPasswordRepository get instance => _instance;

  /// Reset password Repository
  Future<Either<Failure, Map<String, dynamic>>> resetPasswordRepository(
      {required Map<String, dynamic> map}) async {
    try {

      /// --------------------------- Calling API Function ------------------------ ///
      final Either<Failure, Response<Map<String, dynamic>>> res =
          await _createNewPasswordAPI.resetPassword(map: map);
      return res.fold((Failure l) => Left<Failure, Map<String, dynamic>>(l),
          (Response<Map<String, dynamic>> response) {
        if (response.statusCode != 200 ||
            !(response.data!['success'] as bool)) {
          /// Fail (Failure response)
          return Left<Failure, Map<String, dynamic>>(ApiFailure(

              code: response.statusCode,
              resourceName: 'Registration_repository_line_27',
              errors: (response.data!['errors'] as Map<String, dynamic>?) ??
                  <String, String>{}));
        } else {
          /// Success (Successful Repository Operation)
          return Right<Failure, Map<String, dynamic>>(response.data!);
        }
      });
    } on Exception catch (e) {
      /// Fail (Repository Crashed)
      return Left<Failure, Map<String, dynamic>>(ApiFailure(
        errors: <String,String>{'':e.toString()},
        code: 404,
        resourceName: 'CreateNewPassword_repository_line_37',
      ));
    }
  }
}
