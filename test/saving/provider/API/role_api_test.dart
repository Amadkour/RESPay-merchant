import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/provider/API/role_api.dart';

import '../../../authentcation/registration/provider/api/regestration_api_test.mocks.dart';
import '../../../core/utilis.dart';
import '../role_values.dart';

void main() {
  late RoleAPI roleApi;
  late MockDio mockDio;

  setUpAll(() {
    mockDio = MockDio();
    roleApi = RoleAPI(dio: mockDio);
  });

  /// ------------------------Add Role
  group('Add Role Saving test', () {
    test('test on success', () async {
      when(mockDio.post(
        addRoleValue.path,
        data: compare(addRoleValue.successfulBody!),
      )).thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 201,
          data: addRoleValue.successfulResponse,
          requestOptions: RequestOptions(
            path: addRoleValue.path,
          ),
        ),
      );
      expect(
          await roleApi.addRole(
            from: addRoleSuccessBody['from'] as double,
            to: addRoleSuccessBody['to'] as double,
            value: addRoleSuccessBody['value'] as double,
            uuid: addRoleSuccessBody['user_uuid'] as String,
          ),
          isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });

    test('test on failed', () async {
      when(mockDio.post(
        addRoleValue.path,
        data: compare(addRoleValue.failureBody!),
      )).thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 404,
          data: addRoleValue.failureResponse,
          requestOptions: RequestOptions(
            path: addRoleValue.path,
          ),
        ),
      );
      expect(
          await roleApi.addRole(
            from: addRoleFailedBody['from'] as double,
            to: addRoleFailedBody['to'] as double,
            value: addRoleFailedBody['value'] as double,
            uuid: addRoleFailedBody['user_uuid'] as String,
          ),
          isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });
  });

  /// ------------------------Toggle Role
  group('Toggle Role Saving test', () {
    test('test on success', () async {
      when(mockDio.post(
        toggleRoleValue.path,
        data: compare(toggleRoleValue.successfulBody!),
      )).thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 200,
          data: toggleRoleValue.successfulResponse,
          requestOptions: RequestOptions(
            path: toggleRoleValue.path,
          ),
        ),
      );
      expect(
          await roleApi.toggleRole(
              userUUID: toggleRoleSuccessBody['user_uuid'].toString(),
              roleUUID: toggleRoleSuccessBody['uuid'].toString()),
          isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });

    test('test on failed', () async {
      when(mockDio.post(
        toggleRoleValue.path,
        data: compare(toggleRoleValue.failureBody!),
      )).thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 404,
          data: toggleRoleValue.failureResponse,
          requestOptions: RequestOptions(
            path: toggleRoleValue.path,
          ),
        ),
      );
      expect(
          await roleApi.toggleRole(
              userUUID: toggleRoleFailedBody['user_uuid'].toString(),
              roleUUID: toggleRoleFailedBody['uuid'].toString()),
          isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });
  });
  //

  /// ------------------------delete role
  group('Delete Role Saving test', () {
    test('test on success', () async {
      when(mockDio.post(
        deleteRoleValue.path,
        data: compare(deleteRoleValue.successfulBody!),
      )).thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 200,
          data: deleteRoleValue.successfulResponse,
          requestOptions: RequestOptions(
            path: deleteRoleValue.path,
          ),
        ),
      );
      expect(
          await roleApi.deleteRole(
              userUUID: deleteRoleSuccessBody['user_uuid'].toString(),
              roleUUID: deleteRoleSuccessBody['uuid'].toString()),
          isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });

    test('test on failed', () async {
      when(mockDio.post(
        deleteRoleValue.path,
        data: compare(deleteRoleValue.failureBody!),
      )).thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 404,
          data: deleteRoleValue.failureResponse,
          requestOptions: RequestOptions(
            path: deleteRoleValue.path,
          ),
        ),
      );
      expect(
          await roleApi.deleteRole(
              userUUID: deleteRoleFailedBody['user_uuid'].toString(),
              roleUUID: deleteRoleFailedBody['uuid'].toString()),
          isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });
  });

  /// ------------------------Update Role
  group('Update Role Saving test', () {
    test('test on success', () async {
      when(mockDio.post(
        updateRoleValue.path,
        data: compare(updateRoleValue.successfulBody!),
      )).thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 200,
          data: updateRoleValue.successfulResponse,
          requestOptions: RequestOptions(
            path: updateRoleValue.path,
          ),
        ),
      );
      expect(
          await roleApi.updateRole(
            userUUID: updateRoleSuccessBody['uuid'].toString(),
            roleUUID: updateRoleSuccessBody['user_uuid'].toString(),
            from: updateRoleSuccessBody['from'] as double,
            to: updateRoleSuccessBody['to'] as double,
            value: updateRoleSuccessBody['value'] as double,
            isActive: updateRoleSuccessBody['is_active'] as int,
          ),
          isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });
    test('test on failed', () async {
      when(mockDio.post(
        updateRoleValue.path,
        data: compare(updateRoleValue.failureBody!),
      )).thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 404,
          data: updateRoleValue.failureResponse,
          requestOptions: RequestOptions(
            path: updateRoleValue.path,
          ),
        ),
      );
      expect(
          await roleApi.updateRole(
            userUUID: updateRoleFailedBody['uuid'].toString(),
            roleUUID: updateRoleFailedBody['user_uuid'].toString(),
            from: updateRoleFailedBody['from'] as double,
            to: updateRoleFailedBody['to'] as double,
            value: updateRoleFailedBody['value'] as double,
            isActive: updateRoleFailedBody['is_active'] as int,
          ),
          isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });
  });
}
