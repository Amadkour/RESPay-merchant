import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/provider/model/logged_in_user_model.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/provider/API/role_api.dart';

class RoleRepository {
  RoleRepository._singleTone();
  String uuid = loggedInUser.uuid ?? "";
  static final RoleRepository _instance = RoleRepository._singleTone();

  static RoleRepository get instance => _instance;

  /// Add New Role
  Future<Either<Failure, Map<String, dynamic>>> addRoleRepository(
      {required double from, required double to, required double value}) async {
    try {
      final Either<Failure, Response<Map<String, dynamic>>> res =
          await RoleAPI.instance.addRole(uuid: uuid, from: from, to: to, value: value);
      return res.fold((Failure l) => Left<Failure, Map<String, dynamic>>(l), (Response<Map<String, dynamic>> response) {
        if (response.statusCode != 201 || !(response.data!['success'] as bool)) {
          return Left<Failure, Map<String, dynamic>>(ApiFailure(
              code: response.statusCode,
              resourceName: 'add_role_saving_line_31',
              errors: (response.data!['errors'] as Map<String, dynamic>?) ?? <String, String>{}));
        } else {
          return Right<Failure, Map<String, dynamic>>(response.data!);
        }
      });
    } on Exception catch (e) {
      return Left<Failure, Map<String, dynamic>>(ApiFailure(
        errors: <String, String>{'': e.toString()},
        code: 404,
        resourceName: 'CreateNewPassword_repository_line_42',
      ));
    }
  }

  /// delete Role
  Future<Either<Failure, Map<String, dynamic>>> deleteRoleRepository({required String roleUUID}) async {
    try {
      final Either<Failure, Response<Map<String, dynamic>>> res =
          await RoleAPI.instance.deleteRole(userUUID: uuid, roleUUID: roleUUID);
      return res.fold((Failure l) => Left<Failure, Map<String, dynamic>>(l), (Response<Map<String, dynamic>> response) {
        if (response.statusCode != 200 || !(response.data!['success'] as bool)) {
          return Left<Failure, Map<String, dynamic>>(ApiFailure(
              code: response.statusCode,
              resourceName: 'delete_role_saving_line_64',
              errors: (response.data!['errors'] as Map<String, dynamic>?) ?? <String, String>{}));
        } else {
          return Right<Failure, Map<String, dynamic>>(response.data!);
        }
      });
    } on Exception catch (e) {
      return Left<Failure, Map<String, dynamic>>(ApiFailure(
        errors: <String, String>{'': e.toString()},
        code: 404,
        resourceName: 'delete_role_saving_repository_line_75',
      ));
    }
  }

  /// toggle Role
  Future<Either<Failure, Map<String, dynamic>>> toggleRoleRepository({required String roleUUID}) async {
    try {
      final Either<Failure, Response<Map<String, dynamic>>> res =
          await RoleAPI.instance.toggleRole(userUUID: uuid, roleUUID: roleUUID);
      return res.fold((Failure l) => Left<Failure, Map<String, dynamic>>(l), (Response<Map<String, dynamic>> response) {
        if (response.statusCode != 200 || !(response.data!['success'] as bool)) {
          return Left<Failure, Map<String, dynamic>>(ApiFailure(
              code: response.statusCode,
              resourceName: 'delete_role_saving_line_64',
              errors: (response.data!['errors'] as Map<String, dynamic>?) ?? <String, String>{}));
        } else {
          return Right<Failure, Map<String, dynamic>>(response.data!);
        }
      });
    } on Exception catch (e) {
      return Left<Failure, Map<String, dynamic>>(ApiFailure(
        errors: <String, String>{'': e.toString()},
        code: 404,
        resourceName: 'toggle_role_saving_repository_line_108',
      ));
    }
  }

  /// toggle Role
  Future<Either<Failure, Map<String, dynamic>>> updateRoleRepository({
    required String roleUUID,
    required double to,
    required double value,
    required double from,
    required int isActive,
  }) async {
    try {
      final Either<Failure, Response<Map<String, dynamic>>> res = await RoleAPI.instance
          .updateRole(roleUUID: roleUUID, userUUID: uuid, from: from, to: to, value: value, isActive: isActive);
      return res.fold((Failure l) => Left<Failure, Map<String, dynamic>>(l), (Response<Map<String, dynamic>> response) {
        if (response.statusCode != 200 || !(response.data!['success'] as bool)) {
          return Left<Failure, Map<String, dynamic>>(ApiFailure(
              code: response.statusCode,
              resourceName: 'delete_role_saving_line_64',
              errors: (response.data!['errors'] as Map<String, dynamic>?) ?? <String, String>{}));
        } else {
          return Right<Failure, Map<String, dynamic>>(response.data!);
        }
      });
    } on Exception catch (e) {
      return Left<Failure, Map<String, dynamic>>(ApiFailure(
        errors: <String, String>{'': e.toString()},
        code: 404,
        resourceName: 'toggle_role_saving_repository_line_108',
      ));
    }
  }
}
