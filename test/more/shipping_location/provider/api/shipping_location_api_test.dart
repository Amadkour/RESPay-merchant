import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/shipping_location/provider/API/shipping_location_api.dart';

import '../../../../authentcation/registration/provider/api/regestration_api_test.mocks.dart';
import '../../../../core/utilis.dart';
import 'shipping_location_values.dart';

void main() {
  late MockDio mockedDio;
  late ShippingLocationAPI shippingLocationAPI;

  setUpAll(() {
    mockedDio = MockDio();
    shippingLocationAPI = ShippingLocationAPI(dio: mockedDio);
  });

  group('Shipping Location Test', () {
    test('getAddresses api test', () async {
      when(mockedDio.get(getAddressesValues.path)).thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 200,
          data: getAddressesValues.successfulResponse,
          requestOptions: RequestOptions(
            path: getAddressesValues.path,
          ),
        ),
      );
      expect(await shippingLocationAPI.getAddresses(),
          isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });

    test('deleteAddress api test', () async {
      when(mockedDio.post(deleteAddressesValues.path,
              data: compare(deleteAddressesValues.successfulBody!)))
          .thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 200,
          data: deleteAddressesValues.successfulResponse,
          requestOptions: RequestOptions(
            path: deleteAddressesValues.path,
          ),
        ),
      );
      expect(
          await shippingLocationAPI.deleteAddress(
              addressUUID: deleteAddressSuccessBody['address_uuid'] as String),
          isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });

    test('updateAddress api test', () async {
      when(mockedDio.post(updateAddressValues.path,
              data: compare(updateAddressValues.successfulBody!)))
          .thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 200,
          data: updateAddressValues.successfulResponse,
          requestOptions: RequestOptions(
            path: updateAddressValues.path,
          ),
        ),
      );
      expect(
          await shippingLocationAPI.updateAddress(
              addressUUID: updateAddressSuccessBody['address_uuid'] as String,
              isDefault: updateAddressSuccessBody['is_default'] as int),
          isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });


    test('addAddress api test', () async {
      when(mockedDio.post(addAddressValues.path,
              data: compare(addAddressValues.successfulBody!)))
          .thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 201,
          data: addAddressValues.successfulResponse,
          requestOptions: RequestOptions(
            path: addAddressValues.path,
          ),
        ),
      );
      expect(
          await shippingLocationAPI.addAddress(
              phoneNumber: addAddressSuccessBody['phone_number'] as String,
              isDefault: addAddressSuccessBody['is_default'] as int,
              countryUUID: addAddressSuccessBody['country_uuid'] as String,
              cityUUID: addAddressSuccessBody['city_uuid'] as String,
            apartment: addAddressSuccessBody['apartment'] as String,
            zipCode: addAddressSuccessBody['zip_code'] as String,
            state: addAddressSuccessBody['state'] as String,
            streetName: addAddressSuccessBody['street_name'] as String,
          ),
          isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });


  });
}
