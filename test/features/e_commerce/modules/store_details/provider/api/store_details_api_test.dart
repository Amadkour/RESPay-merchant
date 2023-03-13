import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/store_details/provider/api/store_detail_api.dart';

import '../../../../../../authentcation/registration/provider/api/regestration_api_test.mocks.dart';
import '../../store_details_values.dart';


void main(){
  late MockDio mockedDio;
  late StoreDetailApi api;

  setUpAll(() {
    mockedDio = MockDio();
    api = StoreDetailApi.withDio(dio: mockedDio);
  });
  group("getSingleShop", () {
    test('getSingleShop Test', () async {
      when(mockedDio.get("${getSingleShopInfoValues.path}/doloremque-debitis-optio-vitae-omnis")).thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 200,
          data: getSingleShopInfoValues.successfulResponse,
          requestOptions: RequestOptions(
            path: getSingleShopInfoValues.path,
          ),
        );
      });
      final Either<Failure, Response<Map<String, dynamic>>> result = await api.getSingleShop("doloremque-debitis-optio-vitae-omnis");
      expect(result, isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });

    test('getSingleShop Failed Test', () async {
      when(mockedDio.get("${getSingleShopInfoValues.path}/blanditiis-dolorem-consectetur-doloresW")).thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 404,
          data: getSingleShopInfoValues.failureResponse,
          requestOptions: RequestOptions(
            path: getSingleShopInfoValues.path,
          ),
        );
      });
      final Either<Failure, Response<Map<String, dynamic>>> result = await api.getSingleShop("blanditiis-dolorem-consectetur-doloresW");
      expect(result, isA<Left<Failure, Response<Map<String, dynamic>>>>());
    });
  });
}
