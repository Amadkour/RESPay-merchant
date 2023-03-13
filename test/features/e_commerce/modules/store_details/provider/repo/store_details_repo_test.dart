import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/store_details/provider/api/store_detail_api.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/store_details/provider/repos/remote_store_detail_repo.dart';

import '../../store_details_values.dart';
import 'store_details_repo_test.mocks.dart';

@GenerateMocks(<Type>[StoreDetailApi])
void main() {
  late MockStoreDetailApi mockStoreDetailApi;

  late RemoteStoreDetailRepo remoteStoreDetailRepo;

  setUpAll(() {
    mockStoreDetailApi = MockStoreDetailApi();
    remoteStoreDetailRepo = RemoteStoreDetailRepo(mockStoreDetailApi);
  });

  group('get single shop test', () {
    test('test on success', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response = Right<Failure, Response<Map<String, dynamic>>>(
          Response<Map<String, dynamic>>(
              data: getSingleShopInfoValues.successfulResponse,
              statusCode: 200,
              requestOptions: RequestOptions(path: "${getSingleShopInfoValues.path}/doloremque-debitis-optio-vitae-omnis")));

      when(mockStoreDetailApi.getSingleShop("doloremque-debitis-optio-vitae-omnis"))
          .thenAnswer((Invocation realInvocation) async => response);
      expect(await remoteStoreDetailRepo.getSingleShop("doloremque-debitis-optio-vitae-omnis"),
          isA<Right<Failure, ParentModel>>());
    });

    test('get single shop test fail', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response = Right<Failure, Response<Map<String, dynamic>>>(
          Response<Map<String, dynamic>>(
              data: getSingleShopInfoValues.failureResponse,
              statusCode: 404,
              requestOptions: RequestOptions(path:"${getSingleShopInfoValues.path}/blanditiis-dolorem-consectetur-doloresW")));

      when(mockStoreDetailApi.getSingleShop("blanditiis-dolorem-consectetur-doloresW"))
          .thenAnswer((Invocation realInvocation) async => response);
      expect(await remoteStoreDetailRepo.getSingleShop("blanditiis-dolorem-consectetur-doloresW"),
          isA<Left<Failure, ParentModel>>());
    });
  });
}
