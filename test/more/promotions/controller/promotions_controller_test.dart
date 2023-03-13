import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/promotions/controller/promotions_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/promotions/provider/repo/promotions_repo.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/provider/models/promotions_model.dart';

import 'promotions_controller_test.mocks.dart';


@GenerateMocks(<Type>[
  PromotionsRepo,
])
void main() {
  group('Promotions Cubit test', () {
    late MockPromotionsRepo mockPromotionsRepo;
    setUpAll(() {
      mockPromotionsRepo = MockPromotionsRepo();
      when(mockPromotionsRepo.getPromotions()).thenAnswer(
              (Invocation realInvocation) async =>
              Right<Failure, ParentModel>(PromotionsModel()));
    });

    blocTest<PromotionsCubit, PromotionsState>(
      'show method',
      build: () {
        when(mockPromotionsRepo.getPromotions()).thenAnswer(
                (Invocation realInvocation) async =>
                Right<Failure, PromotionsModel>(PromotionsModel()));

        return PromotionsCubit(mockPromotionsRepo);
      },
      act: (PromotionsCubit bloc) async {
        await bloc.getPromotions();
      },
      expect: () => <TypeMatcher<PromotionsState>>[
        isA<PromotionsLoading>(),
        isA<PromotionsLoaded>(),
      ],
    );
    blocTest<PromotionsCubit, PromotionsState>(
      'verify that setCurrentTapIndex method return success',
      build: () => PromotionsCubit(mockPromotionsRepo),
      act: (PromotionsCubit bloc) => bloc.resetState(),
      expect: () => <TypeMatcher<PromotionsState>>[
        isA<PromotionsInitial>(),
      ],
    );
    // blocTest<CustomerLoyaltyCubit, CustomerLoyaltyState>(
    //   'redeem method',
    //   build: () {
    //     when(mockCustomerLoyaltyRepo.redeem("uuid")).thenAnswer(
    //             (Invocation realInvocation) async =>
    //         const Right<Failure, String>(''));
    //
    //     return CustomerLoyaltyCubit(repo: mockCustomerLoyaltyRepo);
    //   },
    //   act: (CustomerLoyaltyCubit bloc) async {
    //     bloc.selectedCustomerLoyalty = CustomerLoyaltyModel(uuid: "uuid");
    //     await bloc.redeem();
    //   },
    //   expect: () => <TypeMatcher<CustomerLoyaltyState>>[
    //     isA<RedeemCustomerLoyaltyLoading>(),
    //     isA<CustomerLoyaltyLoaded>(),
    //     isA<CustomerLoyaltyRedeemed>(),
    //   ],
    // );

    // blocTest<CustomerLoyaltyCubit, CustomerLoyaltyState>(
    //   'oChangRate method',
    //   build: () => CustomerLoyaltyCubit(repo: mockCustomerLoyaltyRepo),
    //   act: (CustomerLoyaltyCubit bloc) async {
    //     bloc.oChangRate(1);
    //   },
    //   expect: () => <TypeMatcher<CustomerLoyaltyState>>[
    //     isA<CustomerLoyaltyChangeRate>(),
    //     isA<CustomerLoyaltyLoaded>(),
    //   ],
    // );
  });
}
