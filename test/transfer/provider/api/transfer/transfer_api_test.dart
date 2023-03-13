import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/api/transfer/transfer_remote_api.dart';

import '../../../../authentcation/registration/provider/api/regestration_api_test.mocks.dart';
import '../../../../core/utilis.dart';
import '../../transfer_values.dart';

void main() {
  late MockDio dio;
  late TransferRemoteApi api;

  setUpAll(() {
    dio = MockDio();
    api = TransferRemoteApi(dio: dio);
  });

  group("make transfer testing", () {
    test("verify that make transfer api return success", () async {
      when(
        dio.post(
          makeTransferValues.path,
          data: compare(createTransferInput.toMap()),
        ),
      ).thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          data: makeTransferValues.successfulResponse,
          requestOptions: RequestOptions(
            path: makeTransferValues.path,
          ),
        );
      });

      final Either<Failure, Response<Map<String, dynamic>>> result = await api.createTransfer(createTransferInput);
      final Object model = result.fold((Failure l) => l, (Response<Map<String, dynamic>> r) => r);
      expect((model as Response<Map<String, dynamic>>).data, equals(makeTransferValues.successfulResponse));
    });

    test("verify that make transfer api return failure", () async {
      when(
        dio.post(
          makeTransferValues.path,
          data: compare(createTransferInput.toMap()),
        ),
      ).thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          data: makeTransferValues.failureResponse,
          requestOptions: RequestOptions(
            path: makeTransferValues.path,
          ),
        );
      });

      final Either<Failure, Response<Map<String, dynamic>>> result = await api.createTransfer(createTransferInput);
      final Object model = result.fold((Failure l) => l, (Response<Map<String, dynamic>> r) => r);
      expect(model, isA<Failure>());
    });
  });
}
