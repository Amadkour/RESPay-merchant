import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/provider/API/saving_api.dart';

import '../../../authentcation/registration/provider/api/regestration_api_test.mocks.dart';
import '../../../core/utilis.dart';
import '../saving_values.dart';

void main() {
  late SavingAPI savingAPI;
  late MockDio mockDio;

  setUpAll(() {
    mockDio = MockDio();
    savingAPI = SavingAPI(dio: mockDio);
  });

  /// ------------------------Get Saving List
  group('Saving API test', () {
    test('Get Saving list test on success', () async {
      when(mockDio.get(
        getSavingListValue.path,
      )).thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 200,
          data: getSavingListValue.successfulResponse,
          requestOptions: RequestOptions(
            path: getSavingListValue.path,
          ),
        ),
      );

      expect(await savingAPI.getSavings(), isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });
    test('Get Saving list test on Failed', () async {
      when(mockDio.get(
        getSavingListValue.path,
      )).thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 422,
          data: getSavingListValue.failureResponse,
          requestOptions: RequestOptions(
            path: getSavingListValue.path,
          ),
        ),
      );

      expect(await savingAPI.getSavings(), isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });
  });

  /// ------------------------Toggle Saving
  group('Toggle Saving test', () {
    test('test on success', () async {
      when(mockDio.post(
        toggleValue.path,
        data: compare(toggleValue.successfulBody!),
      )).thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 200,
          data: toggleValue.successfulResponse,
          requestOptions: RequestOptions(
            path: toggleValue.path,
          ),
        ),
      );
      expect(await savingAPI.toggleSaving(toggleSuccessBody['user_uuid']!),
          isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });

    test('test on failed', () async {
      when(mockDio.post(
        toggleValue.path,
        data: compare(toggleValue.failureBody!),
      )).thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 404,
          data: toggleValue.failureResponse,
          requestOptions: RequestOptions(
            path: toggleValue.path,
          ),
        ),
      );
      expect(await savingAPI.toggleSaving(toggleFailedBody['user_uuid']!),
          isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });
  });

  /// ------------------------Withdraw
  group('Withdraw Saving test', () {
    test('test on success', () async {
      when(mockDio.post(
        withdrawValue.path,
        data: compare(withdrawValue.successfulBody!),
      )).thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 200,
          data: withdrawValue.successfulResponse,
          requestOptions: RequestOptions(
            path: withdrawValue.path,
          ),
        ),
      );
      expect(await savingAPI.withdraw(amount: (withdrawDepositSuccessBody['amount'] as int).toDouble()),
          isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });

    test('test on failed', () async {
      when(mockDio.post(
        withdrawValue.path,
        data: compare(withdrawValue.failureBody!),
      )).thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 422,
          data: withdrawValue.failureResponse,
          requestOptions: RequestOptions(
            path: withdrawValue.path,
          ),
        ),
      );
      expect(await savingAPI.withdraw(amount: (withdrawDepositFailedBody['amount'] as int).toDouble()),
          isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });
  });

  /// ------------------------Deposit
  group('Deposit Saving test', () {
    test('test on success', () async {
      when(mockDio.post(
        depositValue.path,
        data: compare(depositValue.successfulBody!),
      )).thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 200,
          data: depositValue.successfulResponse,
          requestOptions: RequestOptions(
            path: depositValue.path,
          ),
        ),
      );
      expect(await savingAPI.addMoney(amount: (withdrawDepositSuccessBody['amount'] as int).toDouble()),
          isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });

    test('test on failed', () async {
      when(mockDio.post(
        depositValue.path,
        data: compare(depositValue.failureBody!),
      )).thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 422,
          data: depositValue.failureResponse,
          requestOptions: RequestOptions(
            path: depositValue.path,
          ),
        ),
      );
      expect(await savingAPI.addMoney(amount: (withdrawDepositFailedBody['amount'] as int).toDouble()),
          isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });
  });
}
