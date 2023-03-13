import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/api/transfer_options/transfer_options_remote_api.dart';

import '../../../../authentcation/registration/provider/api/regestration_api_test.mocks.dart';
import '../../transfer_values.dart';

void main() {
  late MockDio dio;
  late TransferOptionsRemoteApi api;

  setUpAll(() {
    dio = MockDio();
    api = TransferOptionsRemoteApi(dio: dio);
  });

  group("transfer options testing", () {
    test("verify that get transfer options api return success", () async {
      when(
        dio.get(
          getTransferOptionsValues.path,
        ),
      ).thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          data: getTransferOptionsValues.successfulResponse,
          requestOptions: RequestOptions(
            path: getTransferOptionsValues.path,
          ),
        );
      });

      final Either<Failure, Response<Map<String, dynamic>>> result = await api.get();
      final Object model = result.fold((Failure l) => l, (Response<Map<String, dynamic>> r) => r);
      expect((model as Response<Map<String, dynamic>>).data, equals(getTransferOptionsValues.successfulResponse));
    });

    test("verify that make transfer api return failure", () async {
      when(
        dio.get(
          getTransferOptionsValues.path,
        ),
      ).thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          data: getTransferOptionsValues.failureResponse,
          requestOptions: RequestOptions(
            path: getTransferOptionsValues.path,
          ),
        );
      });

      final Either<Failure, Response<Map<String, dynamic>>> result = await api.get();
      final Object model = result.fold((Failure l) => l, (Response<Map<String, dynamic>> r) => r);
      expect(model, isA<Failure>());
    });
  });
}
