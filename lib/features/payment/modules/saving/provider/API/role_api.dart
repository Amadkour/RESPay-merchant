import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/provider/API/end_point.dart';

class RoleAPI {
  late Dio _dio;

  RoleAPI({Dio? dio}) {
    _dio = dio ?? APIConnection.instance.dio;
  }

  RoleAPI._singleTone() {
    _dio = APIConnection.instance.dio;
  }

  static final RoleAPI _instance = RoleAPI._singleTone();

  static RoleAPI get instance => _instance;

  /// Add New Role
  Future<Either<Failure, Response<Map<String, dynamic>>>> addRole(
      {required double from,
      required double to,
      required double value,
      required String uuid}) async {
    late Response<Map<String, dynamic>> response;

    try {
      final FormData formData = FormData.fromMap(<String, dynamic>{
        'from': from,
        'to': to,
        'value': value,
        'type': 'buying',
        'user_uuid': uuid,
      });
      response = await _dio.post(addRolePath, data: formData);
      return Right<Failure, Response<Map<String, dynamic>>>(response);
    } catch (e) {
      return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure(
          code: response.statusCode,
          resourceName: 'add_money-saving_line_56',
          errors: response.data!['errors'] as Map<String, dynamic>));
    }
  }

  /// delete Role
  Future<Either<Failure, Response<Map<String, dynamic>>>> deleteRole({
    required String roleUUID,
    required String userUUID,
  }) async {
    late Response<Map<String, dynamic>> response;

    try {
      final FormData formData = FormData.fromMap(<String, String>{
        'uuid': roleUUID,
        'user_uuid': userUUID,
      });
      response = await _dio.post(deleteRolePath, data: formData);
      return Right<Failure, Response<Map<String, dynamic>>>(response);
    } catch (e) {
      return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure(
          code: response.statusCode,
          resourceName: 'delete_role-saving_line_72',
          errors: response.data!['errors'] as Map<String, dynamic>));
    }
  }

  /// toggle Role
  Future<Either<Failure, Response<Map<String, dynamic>>>> toggleRole({
    required String roleUUID,
    required String userUUID,
  }) async {
    late Response<Map<String, dynamic>> response;

    try {
      final FormData formData = FormData.fromMap(<String, String>{
        'uuid': roleUUID,
        'user_uuid': userUUID,
      });
      response = await _dio.post(toggleRolePath, data: formData);
      return Right<Failure, Response<Map<String, dynamic>>>(response);
    } catch (e) {
      return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure(
          code: response.statusCode,
          resourceName: 'delete_role-saving_line_95',
          errors: response.data!['errors'] as Map<String, dynamic>));
    }
  }

  /// update Role
  Future<Either<Failure, Response<Map<String, dynamic>>>> updateRole({
    required String roleUUID,
    required String userUUID,
    required double from,
    required double to,
    required double value,
    required int isActive,
  }) async {
    late Response<Map<String, dynamic>> response;

    try {
      final FormData formData = FormData.fromMap(<String, dynamic>{
        'uuid': roleUUID,
        'user_uuid': userUUID,
        'from': from,
        'to': to,
        'value': value,
        'type': 'buying',
        'is_active': isActive,
      });
      response = await _dio.post(updateRolePath, data: formData);
      return Right<Failure, Response<Map<String, dynamic>>>(response);
    } catch (e) {
      return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure(
          code: response.statusCode,
          resourceName: 'update_role-saving_line_132',
          errors: response.data!['errors'] as Map<String, dynamic>));
    }
  }
}
