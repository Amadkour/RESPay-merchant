import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/settings/modules/change_password/provider/API/change_password_api.dart';

import '../../../../../authentcation/registration/provider/api/regestration_api_test.mocks.dart';
import '../../../../../core/utilis.dart';
import 'change_password_values.dart';

void main() {
  late MockDio mockDio;
  late ChangePasswordAPI changePasswordAPI;

  setUpAll(() {
    mockDio = MockDio();
    changePasswordAPI = ChangePasswordAPI(dio: mockDio);
  });

  group('change Password  API test', () {
    test('getFAQs api test', () async {
      when(mockDio.post(changePasswordValues.path,
              data: compare(changePasswordValues.successfulBody!)))
          .thenAnswer((Invocation realInvocation) async =>
              Response<Map<String, dynamic>>(
                  requestOptions:
                      RequestOptions(path: changePasswordValues.path),
                  data: changePasswordValues.successfulResponse,
                  statusCode: 200));

      expect(
          await changePasswordAPI.changePassword(
              oldPassword: changePasswordSuccessBody['old_password'] as String,
              newPassword: changePasswordSuccessBody['new_password'] as String,
              newPasswordConfirmation:
                  changePasswordSuccessBody['new_password_confirmation']
                      as String),
          isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });
  });
}
