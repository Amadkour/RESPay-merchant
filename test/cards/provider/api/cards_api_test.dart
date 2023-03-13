import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/exceptions.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/provider/API/cards_api.dart';

import '../../../authentcation/registration/provider/api/regestration_api_test.mocks.dart';
import '../card_values.dart';

void main() {
  late MockDio mockedDio;

  late CardsAPI api;
  setUpAll(() {
    mockedDio = MockDio();
    api = CardsAPI(dio: mockedDio);
  });

  group('cards api layer testing', () {
    //-----testing get paymentMethod function ----//

    test('verify that get payment method return a map ', () async {
      when(mockedDio.get(paymentMethodValues.path)).thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 200,
          data: paymentMethodValues.successfulResponse,
          requestOptions: RequestOptions(
            path: paymentMethodValues.path,
          ),
        );
      });

      final Map<String, dynamic> result = await api.getPaymentMethods();

      expect(result, isA<Map<String, dynamic>>());
    });

    test('verify that get payment method throws exception ', () async {
      when(mockedDio.get(paymentMethodValues.path)).thenThrow(DioError(
        requestOptions: RequestOptions(
          path: paymentMethodValues.path,
        ),
      ));

      expect(() => api.getPaymentMethods(), throwsA(isA<ServerException>()));
    });

//-----testing get user credit card function ----//

    test('verify that get cards method return a map ', () async {
      when(mockedDio.get(getCreditCardsMethodValues.path)).thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 200,
          data: getCreditCardsMethodValues.successfulResponse,
          requestOptions: RequestOptions(
            path: getCreditCardsMethodValues.path,
          ),
        );
      });

      final Map<String, dynamic> result = await api.getCreditCards();

      expect(result, isA<Map<String, dynamic>>());
    });

    test('verify that get cards method throws exception ', () async {
      when(mockedDio.get(getCreditCardsMethodValues.path)).thenThrow(DioError(
        requestOptions: RequestOptions(
          path: paymentMethodValues.path,
        ),
      ));

      expect(() => api.getCreditCards(), throwsA(isA<ServerException>()));
    });

    //-----testing add  credit card function ----//

    test('verify that delete cards method success ', () async {
      when(mockedDio.post(
        deleteCreditCardValues.path,
        data: deleteCreditCardValues.successfulParams,
      )).thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 200,
          data: deleteCreditCardValues.successfulResponse,
          requestOptions: RequestOptions(
            path: deleteCreditCardValues.path,
          ),
        );
      });

      final bool result = await api.deleteCard(deleteCreditCardValues.successfulParams!['card_uuid'] as String);

      expect(result, true);
    });

    test('verify that delete card method throws exception ', () async {
      when(mockedDio.post(
        deleteCreditCardValues.path,
        data: deleteCreditCardValues.failureParams,
      )).thenThrow(DioError(
        requestOptions: RequestOptions(
          path: paymentMethodValues.path,
        ),
      ));

      expect(() => api.deleteCard(deleteCreditCardValues.failureParams!['card_uuid'] as String),
          throwsA(isA<ServerException>()));
    });
  });
}
