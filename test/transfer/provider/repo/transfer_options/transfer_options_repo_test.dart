// ignore_for_file: always_specify_types

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/api/transfer_options/transfer_options_remote_api.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/transfer_options_model.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/repos/transfer_options/transfer_options_repo.dart';

import '../../transfer_values.dart';
import 'transfer_options_repo_test.mocks.dart';

@GenerateMocks([TransferOptionsRemoteApi])
void main() {
  late MockTransferOptionsRemoteApi api;
  late TransferOptionsRepo repo;
  late TransferOptionsModel model;
  setUpAll(() {
    api = MockTransferOptionsRemoteApi();
    repo = TransferOptionsRepo(api);
    final TransferOptionsModel converter = TransferOptionsModel();
    model = converter.fromJsonInstance(getTransferOptionsValues.successfulResponse['data'] as Map<String, dynamic>);
  });

  group('get transfer options testing', () {
    test("verify transfer options returns success", () async {
      when(api.get()).thenAnswer((Invocation realInvocation) async {
        return right(Response<Map<String, dynamic>>(
          data: getTransferOptionsValues.successfulResponse,
          statusCode: 200,
          requestOptions: RequestOptions(
            path: getTransferOptionsValues.path,
          ),
        ));
      });

      final Either<Failure, ParentModel> result = await repo.get();
      final Object value = result.fold((Failure l) => l, (ParentModel r) => r);
      expect(value, equals(model));
    });

    test("verify transfer options returns failure", () async {
      when(api.get()).thenThrow((Invocation realInvocation) async {
        return ApiFailure();
      });

      final Either<Failure, ParentModel> result = await repo.get();
      final Object value = result.fold((Failure l) => l, (ParentModel r) => r);
      expect(value, isA<Failure>());
    });
  });
}
