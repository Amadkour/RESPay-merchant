import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';

import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/local_storage_service.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/controller/country_type/country_type_cubit.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/controller/login_cubit.dart';
import 'package:res_pay_merchant/features/authentication/modules/pin_code/controller/pin_code_cubit.dart';

import 'package:res_pay_merchant/features/dashboard/modules/home/controller/hom_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/controller/card_limit/card_limit_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/controller/cards_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/notification/controller/notification_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/controller/more%20cubit/more_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/controller/schedual_cubit/schedual_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/customer_loyality/controller/customer_loyalty_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/profile/controller/profile_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/promotions/controller/promotions_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/referral/controller/referral_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/shipping_location/controller/shipping_location_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/support/controller/support_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/shop/controller/shop_cubit.dart';

import 'package:res_pay_merchant/features/e_commerce/controller/e_commerce_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/controller/cart_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/controller/celebrity_list_controller/celebrity_cubit_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/controller/celebrity_list_controller/celebrity_cubit_state.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/checkout/controller/checkout_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/favourite/controller/favourite_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/controller/orders_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/store_details/controller/store_detail_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/provider/models/filter_item.dart';
import 'package:res_pay_merchant/features/payment/modules/amount/controller/transaction_amount_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/analytics/controller/analytics_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/bank_name/controller/bank_name_controller/bank_name_cubit.dart';

import 'package:res_pay_merchant/features/payment/modules/beneficiary/controller/beneficiary_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/controller/budget_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/category/controller/cubit/category_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/deposit/controller/deposit_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/gift/controller/gift_cubit/gift_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/history/controller/transaction_history_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/pay_bill/controller/bill_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/request/controller/request_cubit/request_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/controller/saving_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/controller/transfer_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/controller/transfer_options/transfer_options_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/withdraw/controller/withdraw_cubit.dart';

import 'set_up_test.mocks.dart';

@GenerateMocks(<Type>[
  GlobalCubit,
  LoginCubit,
  PinCodeCubit,
  TransferCubit,
  TransferOptionsCubit,
  ScheduleCubit,
  NotificationCubit,
  CardsCubit,
  CardLimitCubit,
  RequestCubit,
  DepositCubit,
  PromotionsCubit,
  CountryTypeCubit,
  BankNameCubit,
  CategoryCubit,
  TransactionAmountCubit,
  TransactionHistoryCubit,
  GiftCubit,
  MoreCubit,
  AnalyticsCubit,
  BillCubit,
  BeneficiaryCubit,
  BudgetCubit,
  ProfileCubit,
  ReferralCubit,
  CelebrityCubit,
  SupportCubit,
  SavingCubit,
  WithdrawCubit,
  OrdersCubit,
  CustomerLoyaltyCubit,
  ECommerceCubit,
  StoreDetailCubit,
  ShippingLocationCubit,
  CartCubit,
  FavoriteCubit,
  ShopCubit,
  HomCubit,
  CheckoutCubit,
  FlutterSecureStorage,
  LocalStorageService
])
List<Object> list = <Object>[
  MockGlobalCubit(),
  MockLoginCubit(),
  MockPinCodeCubit(),
  MockTransferCubit(),
  MockTransferOptionsCubit(),
  MockScheduleCubit(),
  MockNotificationCubit(),
  MockCardsCubit(),
  MockCardLimitCubit(),
  MockRequestCubit(),
  MockDepositCubit(),
  MockPromotionsCubit(),
  MockCountryTypeCubit(),
  MockBankNameCubit(),
  MockCategoryCubit(),
  MockTransactionAmountCubit(),
  MockTransactionHistoryCubit(),
  MockGiftCubit(),
  MockMoreCubit(),
  MockAnalyticsCubit(),
  MockBillCubit(),
  MockBeneficiaryCubit(),
  MockBudgetCubit(),
  MockProfileCubit(),
  MockReferralCubit(),
  MockCelebrityCubit(),
  MockSupportCubit(),
  MockSavingCubit(),
  MockWithdrawCubit(),
  MockOrdersCubit(),
  MockCustomerLoyaltyCubit(),
  MockECommerceCubit(),
  MockStoreDetailCubit(),
  MockShippingLocationCubit(),
  MockCartCubit(),
  MockShopCubit(),
  MockHomCubit(),
  MockCheckoutCubit(),
  MockFlutterSecureStorage(),
  MockLocalStorageService()
];

// class UnitTestExecution {
//   UnitTestExecution() {
//     mockTest();
//   }
//   void mockTest() {
//     for (int i = 0; i < list.length; i++) {
//       sl.registerLazySingleton(() => list[i]);
//     }
//   }
// }

void mockTest() {
  sl.registerLazySingleton<BillCubit>(() => MockBillCubit());
  sl.registerLazySingleton<RequestCubit>(() => MockRequestCubit());
  sl.registerLazySingleton<BeneficiaryCubit>(() => MockBeneficiaryCubit());
  sl.registerLazySingleton<CardsCubit>(() => MockCardsCubit());
  sl.registerLazySingleton<ReferralCubit>(() => MockReferralCubit());
  sl.registerLazySingleton<CardLimitCubit>(() => MockCardLimitCubit());
  sl.registerLazySingleton<CelebrityCubit>(() {
    final MockCelebrityCubit cubit = MockCelebrityCubit();
    final Stream<CelebrityState> stream =
        Stream<CelebrityState>.fromIterable(<CelebrityState>[
      CelebrityInitial(),
      CelebrityLoading(),
      CelebrityLoaded(),
    ]);

    when(cubit.stream).thenAnswer(
      (Invocation i) => stream,
    );
    when(cubit.state).thenReturn(CelebrityLoaded());
    return cubit;
  });
  sl.registerLazySingleton<CartCubit>(() {
    final MockCartCubit cubit = MockCartCubit();
    when(cubit.stream).thenAnswer(
      (Invocation realInvocation) => Stream.fromIterable(
        [
          CartInitial(),
          CartLoading(),
          CartLoaded(),
        ],
      ),
    );

    when(cubit.state).thenReturn(CartLoaded());
    return cubit;
  });

  sl.registerLazySingleton<ECommerceCubit>(() {
    final MockECommerceCubit cubit = MockECommerceCubit();
    when(cubit.celebrityFilters).thenReturn(<FilterItem>[]);
    when(cubit.stream).thenAnswer(
        (Invocation realInvocation) => Stream<ECommerceState>.fromIterable([
              ECommerceInitial(),
              ECommerceLoading(),
              ECommerceLoaded(),
              ECommerceError(),
            ]));
    when(cubit.state).thenReturn(ECommerceLoaded());
    return cubit;
  });

  sl.registerLazySingleton<HomCubit>(() {
    final MockHomCubit x = MockHomCubit();
    when(x.stream)
        .thenAnswer((Invocation realInvocation) => Stream.fromIterable([
              HomInitial(),
            ]));

    when(x.state).thenReturn(HomInitial());
    return x;
  });

  // sl.registerLazySingleton<FavoriteCubit>(() {
  //   final MockFavouriteCubit cubit = MockFavouriteCubit();

  //   when(cubit.stream).thenAnswer(
  //     (Invocation realInvocation) => Stream.fromIterable(
  //       [
  //         FavoriteInitial(),
  //         AddToFavourite(),
  //         RemoveFromFavourite(),
  //         FavoritesLoading(),
  //         FavoriteCubitItemUpdateStateLoading(),
  //         FavoritesLoaded(),
  //         ItemAdditionInFavouriteLoading(),
  //         FavoritesError(),
  //       ],
  //     ),
  //   );

  // });

  //   when(cubit.state).thenReturn(FavoritesLoaded());
  //   return cubit;
  // });
  sl.registerLazySingleton<GlobalCubit>(() {
    final MockGlobalCubit x = MockGlobalCubit();
    when(x.stream).thenAnswer((Invocation realInvocation) =>
        Stream.fromIterable([
          AppInitial(),
          LanguageChanged(),
          TextFieldChanged(),
          GlobalInitial()
        ]));

    when(x.state).thenReturn(TextFieldChanged());
    return x;
  });

  sl.registerLazySingleton<FlutterSecureStorage>(
      () => MockFlutterSecureStorage());
}
