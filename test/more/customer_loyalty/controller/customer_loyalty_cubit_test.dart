import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/customer_loyality/controller/customer_loyalty_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/customer_loyality/provider/models/customer_loyality_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/customer_loyality/provider/models/customer_loyalty_list_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/customer_loyality/provider/repo/customer_repo.dart';

import 'customer_loyalty_cubit_test.mocks.dart';

@GenerateMocks(<Type>[
  CustomerLoyaltyRepo,
])
void main() {
  group('Customer Loyalty Cubit test', () {
    late MockCustomerLoyaltyRepo mockCustomerLoyaltyRepo;
    setUpAll(() {
      mockCustomerLoyaltyRepo = MockCustomerLoyaltyRepo();
      when(mockCustomerLoyaltyRepo.getLoyalties()).thenAnswer(
          (Invocation realInvocation) async =>
              Right<Failure, ParentModel>(CustomerLoyaltyListModel()));
    });

    blocTest<CustomerLoyaltyCubit, CustomerLoyaltyState>(
      'show method',
      build: () {
        when(mockCustomerLoyaltyRepo.show("uuid")).thenAnswer(
            (Invocation realInvocation) async =>
                Right<Failure, CustomerLoyaltyModel>(
                    CustomerLoyaltyModel(uuid: "uuid")));

        return CustomerLoyaltyCubit(repo: mockCustomerLoyaltyRepo);
      },
      act: (CustomerLoyaltyCubit bloc) async {
        await bloc.show(CustomerLoyaltyModel(uuid: "uuid"));
      },
      expect: () => <TypeMatcher<CustomerLoyaltyState>>[
        isA<ShowCustomerLoyaltyLoading>(),
        isA<CustomerLoyaltyLoaded>(),
        isA<CustomerLoyaltyLoaded>(),
      ],
    );

    blocTest<CustomerLoyaltyCubit, CustomerLoyaltyState>(
      'redeem method',
      build: () {
        when(mockCustomerLoyaltyRepo.redeem("uuid")).thenAnswer(
            (Invocation realInvocation) async =>
                const Right<Failure, String>(''));

        return CustomerLoyaltyCubit(repo: mockCustomerLoyaltyRepo);
      },
      act: (CustomerLoyaltyCubit bloc) async {
        bloc.selectedCustomerLoyalty = CustomerLoyaltyModel(uuid: "uuid");
        await bloc.redeem();
      },
      expect: () => <TypeMatcher<CustomerLoyaltyState>>[
        isA<RedeemCustomerLoyaltyLoading>(),
        isA<CustomerLoyaltyLoaded>(),
        isA<CustomerLoyaltyRedeemed>(),
      ],
    );

    blocTest<CustomerLoyaltyCubit, CustomerLoyaltyState>(
      'oChangRate method',
      build: () => CustomerLoyaltyCubit(repo: mockCustomerLoyaltyRepo),
      act: (CustomerLoyaltyCubit bloc) async {
        bloc.oChangRate(1);
      },
      expect: () => <TypeMatcher<CustomerLoyaltyState>>[
        isA<CustomerLoyaltyChangeRate>(),
        isA<CustomerLoyaltyLoaded>(),
      ],
    );
  });
}
