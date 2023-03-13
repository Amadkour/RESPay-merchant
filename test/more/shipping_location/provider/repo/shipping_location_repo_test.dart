import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/shipping_location/provider/API/shipping_location_api.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/shipping_location/provider/model/address_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/shipping_location/provider/repository/shipping_location_repository.dart';

import '../api/shipping_location_values.dart';
import 'shipping_location_repo_test.mocks.dart';

@GenerateMocks(<Type>[
  ShippingLocationAPI,
])
void main() {
  late ShippingLocationRepository shippingLocationRepository;
  late MockShippingLocationAPI mockShippingLocationAPI;

  setUpAll(() {
    mockShippingLocationAPI = MockShippingLocationAPI();
    shippingLocationRepository = ShippingLocationRepository(
        shippingLocationAPI: mockShippingLocationAPI);
  });

  group('Shipping location repo test', () {

    test('get addresses success', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response =
          Right<Failure, Response<Map<String, dynamic>>>(
              Response<Map<String, dynamic>>(
        statusCode: 200,
        data: getAddressesValues.successfulResponse,
        requestOptions: RequestOptions(
          path: getAddressesValues.path,
        ),
      ));

      when(mockShippingLocationAPI.getAddresses())
          .thenAnswer((Invocation realInvocation) async => response);

      expect(await shippingLocationRepository.getAddressesRepository(),
          isA<Right<Failure, List<AddressModel>>>());
    });

    test('update address success', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response =
          Right<Failure, Response<Map<String, dynamic>>>(
              Response<Map<String, dynamic>>(
        statusCode: 200,
        data: updateAddressValues.successfulResponse,
        requestOptions: RequestOptions(
          path: updateAddressValues.path,
        ),
      ));

      when(mockShippingLocationAPI.updateAddress(
              addressUUID: updateAddressSuccessBody['address_uuid'] as String,
              isDefault: updateAddressSuccessBody['is_default'] as int))
          .thenAnswer((Invocation realInvocation) async => response);

      expect(
          await shippingLocationRepository.updateAddressRepository(
              addressUUID: updateAddressSuccessBody['address_uuid'] as String,
              isDefault: updateAddressSuccessBody['is_default'] as int),
          isA<Right<Failure, Map<String, dynamic>>>());
    });

    test('delete address success', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response =
          Right<Failure, Response<Map<String, dynamic>>>(
              Response<Map<String, dynamic>>(
        statusCode: 200,
        data: deleteAddressesValues.successfulResponse,
        requestOptions: RequestOptions(
          path: deleteAddressesValues.path,
        ),
      ));

      when(mockShippingLocationAPI.deleteAddress(
        addressUUID: deleteAddressSuccessBody['address_uuid'] as String,
      )).thenAnswer((Invocation realInvocation) async => response);

      expect(
          await shippingLocationRepository.deleteAddressesRepository(
              addressUUID: deleteAddressSuccessBody['address_uuid'] as String,
              ),
          isA<Right<Failure, Map<String, dynamic>>>());
    });

    test('add address success', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response =
      Right<Failure, Response<Map<String, dynamic>>>(
          Response<Map<String, dynamic>>(
            statusCode: 201,
            data: addAddressValues.successfulResponse,
            requestOptions: RequestOptions(
              path: addAddressValues.path,
            ),
          ));

      when(mockShippingLocationAPI.addAddress(
        phoneNumber: addAddressSuccessBody['phone_number'] as String,
        isDefault: addAddressSuccessBody['is_default'] as int,
        countryUUID: addAddressSuccessBody['country_uuid'] as String,
        cityUUID: addAddressSuccessBody['city_uuid'] as String,
        apartment: addAddressSuccessBody['apartment'] as String,
        zipCode: addAddressSuccessBody['zip_code'] as String,
        state: addAddressSuccessBody['state'] as String,
        streetName: addAddressSuccessBody['street_name'] as String,
      )).thenAnswer((Invocation realInvocation) async => response);

      expect(
          await shippingLocationRepository.addAddressesRepository(
            phoneNumber: addAddressSuccessBody['phone_number'] as String,
            isDefault: addAddressSuccessBody['is_default'] as int,
            countryUUID: addAddressSuccessBody['country_uuid'] as String,
            cityUUID: addAddressSuccessBody['city_uuid'] as String,
            apartment: addAddressSuccessBody['apartment'] as String,
            zipCode: addAddressSuccessBody['zip_code'] as String,
            state: addAddressSuccessBody['state'] as String,
            streetName: addAddressSuccessBody['street_name'] as String,
          ),
          isA<Right<Failure, AddressModel>>());
    });

  });
}
