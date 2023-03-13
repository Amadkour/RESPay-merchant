import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/shipping_location/controller/shipping_location_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/shipping_location/provider/model/address_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/shipping_location/provider/model/city_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/shipping_location/provider/repository/shipping_location_repository.dart';

import '../provider/api/shipping_location_values.dart';
import 'shipping_location_cubit_test.mocks.dart';

@GenerateMocks(<Type>[
  ShippingLocationRepository,
])
void main() {
  late MockShippingLocationRepository repository;
  setUpAll(() {
    repository = MockShippingLocationRepository();
    when(repository.getAddressesRepository()).thenAnswer(
        (Invocation realInvocation) async =>
            const Right<Failure, List<AddressModel>>(<AddressModel>[]));
  });

  group('Shipping Location Test', () {
    blocTest<ShippingLocationCubit, ShippingLocationState>('updateScreen test',
        build: () => ShippingLocationCubit(repository),
        act: (ShippingLocationCubit bloc) => bloc.updateScreen(),
        expect: () => <TypeMatcher<ShippingLocationState>>[
              isA<ShippingLocationUpdateScreen>(),
              isA<ShippingLocationGetAddressesLoaded>(),
            ],
        verify: (ShippingLocationCubit cubit) =>
            verify(repository.getAddressesRepository()).called(1));

    blocTest<ShippingLocationCubit, ShippingLocationState>(
      'changeDefaultAddress test',
      build: () => ShippingLocationCubit(repository),
      act: (ShippingLocationCubit bloc) {
        bloc.isDefaultAddressCheckBoxValue = true;

        bloc.changeDefaultAddress(value: false);
      },
      expect: () => <TypeMatcher<ShippingLocationState>>[
        isA<ShippingLocationChangeCheckBoxValue>(),
        isA<ShippingLocationGetAddressesLoaded>(),
      ],
    );

    blocTest<ShippingLocationCubit, ShippingLocationState>(
      'changeCity test',
      build: () => ShippingLocationCubit(repository),
      act: (ShippingLocationCubit bloc) {
        bloc.isDefaultAddressCheckBoxValue = true;
        bloc.changeCity(cityModel: CityModel());
      },
      expect: () => <TypeMatcher<ShippingLocationState>>[
        isA<ShippingLocationChangeCity>(),
        isA<ShippingLocationGetAddressesLoaded>(),
      ],
    );

    blocTest<ShippingLocationCubit, ShippingLocationState>(
      'changeSelectedAddress test',
      build: () => ShippingLocationCubit(repository),
      act: (ShippingLocationCubit bloc) {
        bloc.isDefaultAddressCheckBoxValue = true;
        bloc.changeSelectedAddress(0);
      },
      expect: () => <TypeMatcher<ShippingLocationState>>[
        isA<ShippingLocationChangeAddress>(),
        isA<ShippingLocationGetAddressesLoaded>(),
      ],
    );


    blocTest<ShippingLocationCubit, ShippingLocationState>(
      'determineAddressDetails test',
      build: () => ShippingLocationCubit(repository),
      act: (ShippingLocationCubit bloc) {
        bloc.determineAddressDetails();
      },
      expect: () => <TypeMatcher<ShippingLocationState>>[
        isA<ShippingLocationCurrentPositionLoad>(),
        isA<ShippingLocationGetAddressesLoaded>(),
        isA<ShippingLocationCurrentPositionLoaded>(),
      ],
    );


    blocTest<ShippingLocationCubit, ShippingLocationState>(
      'deleteAddress test',
      build: () {
        when(repository.deleteAddressesRepository(
            addressUUID: deleteAddressSuccessBody['address_uuid'] as String));
        return ShippingLocationCubit(repository);
      },
      act: (ShippingLocationCubit bloc) async {
        bloc.addresses = <AddressModel>[AddressModel()];
        await bloc.deleteAddress(0);
      },
      expect: () => <TypeMatcher<ShippingLocationState>>[
        isA<ShippingLocationCurrentPositionLoad>(),
        isA<ShippingLocationGetAddressesLoaded>(),
        isA<ShippingLocationCurrentPositionLoaded>(),
      ],
    );
  });
}
