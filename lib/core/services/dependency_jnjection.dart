import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import 'package:res_pay_merchant/core/configuration/init_app.dart';
import 'package:res_pay_merchant/core/configuration/top_level_configuration.dart';

import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/currency_base_api.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/currency_remote_api.dart';
import 'package:res_pay_merchant/core/public_module/provider/repos/currency_repo.dart';
import 'package:res_pay_merchant/core/res/utils/pdf_service.dart';
import 'package:res_pay_merchant/core/res/utils/screen_shot_service.dart';
import 'package:res_pay_merchant/core/res/utils/share_service.dart';
import 'package:res_pay_merchant/core/services/local_storage_service.dart';
import 'package:res_pay_merchant/core/services/notification_service.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/controller/country_type/country_type_cubit.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/controller/login_cubit.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/provider/repository/login_repository.dart';
import 'package:res_pay_merchant/features/authentication/modules/pin_code/controller/pin_code_cubit.dart';

import 'package:res_pay_merchant/features/dashboard/modules/home/controller/hom_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/controller/card_limit/card_limit_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/controller/cards_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/provider/repository/cards_section_repository.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/notification/controller/notification_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/controller/more%20cubit/more_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/controller/schedual_cubit/schedual_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/customer_loyality/controller/customer_loyalty_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/customer_loyality/provider/api/customer_loyalty_api.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/customer_loyality/provider/repo/customer_repo.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/language/provider/API/language_api.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/language/provider/repository/language_repository.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/profile/controller/profile_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/profile/provider/API/profile_api.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/profile/provider/repository/profile_repository.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/promotions/controller/promotions_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/promotions/provider/api/promotions_api.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/promotions/provider/repo/promotions_repo.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/referral/controller/referral_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/referral/provider/api/referral/remote_referral_api.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/referral/provider/repo/remote_api_repo.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/shipping_location/controller/shipping_location_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/shipping_location/provider/repository/shipping_location_repository.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/support/controller/support_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/support/provider/api/support_remote_api.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/support/provider/repo/support_repo.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/providers/apis/more/local_more_api.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/providers/repos/more_repo.dart';
import 'package:res_pay_merchant/features/dashboard/modules/shop/controller/shop_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/shop/provider/repo/shop_repo.dart';

import 'package:res_pay_merchant/features/e_commerce/controller/e_commerce_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/controller/cart_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/provider/api/cart_api.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/provider/repo/remote_cart_repo.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/controller/celebrity_list_controller/celebrity_cubit_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/api/base_celebrity_api.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/api/remote_celebrity_api.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/repo/remote_celebrity_list_repo.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/checkout/controller/checkout_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/favourite/controller/favourite_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/favourite/provider/api/favourite_api.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/favourite/provider/repo/remote_favourite_repo.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/controller/orders_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/api/base_orders_api.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/api/remote_order_api.dart';

import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/repo/orders_repo.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/store_details/controller/store_detail_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/store_details/provider/api/store_detail_api.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/store_details/provider/repos/remote_store_detail_repo.dart';
import 'package:res_pay_merchant/features/payment/modules/amount/controller/transaction_amount_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/analytics/controller/analytics_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/analytics/provider/api/base_analytics_api.dart';
import 'package:res_pay_merchant/features/payment/modules/analytics/provider/api/remote_analytics_api.dart';
import 'package:res_pay_merchant/features/payment/modules/analytics/provider/repo/analytics_repo.dart';
import 'package:res_pay_merchant/features/payment/modules/bank_name/controller/bank_name_controller/bank_name_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/bank_name/provider/api/bank_name/bank_name_remote_api.dart';
import 'package:res_pay_merchant/features/payment/modules/bank_name/provider/repos/bank_name/bank_name_repo.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/controller/beneficiary_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/controller/budget_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/provider/api/base_budget_api.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/provider/api/remote_budget_api.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/provider/repo/budget_repo.dart';
import 'package:res_pay_merchant/features/payment/modules/category/controller/cubit/category_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/category/provider/api/base_category_api.dart';
import 'package:res_pay_merchant/features/payment/modules/category/provider/api/json_category_api.dart';
import 'package:res_pay_merchant/features/payment/modules/category/provider/repos/category_repo.dart';
import 'package:res_pay_merchant/features/payment/modules/deposit/controller/deposit_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/deposit/provider/api/deposit_api.dart';
import 'package:res_pay_merchant/features/payment/modules/deposit/provider/repo/deposit_repo.dart';
import 'package:res_pay_merchant/features/payment/modules/gift/controller/gift_cubit/gift_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/gift/provider/api/gift_remote_api.dart';
import 'package:res_pay_merchant/features/payment/modules/gift/provider/repos/gift_repo/gift_repo.dart';
import 'package:res_pay_merchant/features/payment/modules/history/controller/transaction_history_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/history/provider/api/base_transaction_api.dart';
import 'package:res_pay_merchant/features/payment/modules/history/provider/api/remote_transaction_api.dart';
import 'package:res_pay_merchant/features/payment/modules/history/provider/repos/transaction_repo.dart';
import 'package:res_pay_merchant/features/payment/modules/pay_bill/controller/bill_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/pay_bill/provider/repo/bill_repo.dart';
import 'package:res_pay_merchant/features/payment/modules/request/controller/request_cubit/request_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/request/provider/api/request_remote_api.dart';
import 'package:res_pay_merchant/features/payment/modules/request/provider/repos/request_repo.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/controller/saving_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/provider/respository/role_repository.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/provider/respository/saving_repository.dart';
import 'package:res_pay_merchant/features/payment/modules/transaction_types/controller/transaction_type_dart_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transaction_types/provider/repos/more_repository.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/controller/transfer_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/controller/transfer_options/transfer_options_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/api/beneficiary/beneficiary_remote_api.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/api/transfer/transfer_base_api.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/api/transfer/transfer_remote_api.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/api/transfer_options/transfer_options_remote_api.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/repos/beneficiary/beneficiary_repo.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/repos/transfer/transfer_repo.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/repos/transfer_options/transfer_options_repo.dart';
import 'package:res_pay_merchant/features/payment/modules/withdraw/controller/withdraw_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/withdraw/provider/repository/withdraw_repo.dart';

final GetIt sl = GetIt.instance;

Future<void> setUp() async {
  if (isSecure) {
    const MethodChannel pluginChannel = MethodChannel("res_secure");
    await pluginChannel.invokeMethod("make_secure");
  }
  //! packages
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton(() => FlutterLocalNotificationsPlugin());

  //!services
  sl.registerLazySingleton(() => LocalStorageService(sl()));
  sl.registerLazySingleton(() => ScreenShotService());
  sl.registerLazySingleton(() => ShareService());
  sl.registerLazySingleton(() => PdfService());
  sl.registerSingleton(NotificationService(sl()));

  sl.registerLazySingleton(() => GlobalCubit());
  //! api connections
  sl.registerLazySingleton(() => APIConnection.instance);
  //! authentication

  sl.registerFactory(() => LoginCubit(LoginRepository.instance));

  //! pinCode
  sl.registerLazySingleton(() => PinCodeCubit());
  //! transfer
  sl.registerLazySingleton<TransferBaseApi>(() => TransferRemoteApi());
  sl.registerLazySingleton(() => TransferRepo(sl()));
  sl.registerLazySingleton(() => TransferCubit());
  //! transfer options
  sl.registerLazySingleton(() => TransferOptionsRemoteApi());
  sl.registerLazySingleton(() => TransferOptionsRepo(sl()));
  //! currency
  sl.registerLazySingleton<CurrencyBaseApi>(() => CurrencyRemoteApi());
  sl.registerLazySingleton(() => CurrencyRepository(sl()));

  sl.registerLazySingleton(() => TransferOptionsCubit(sl()));
  sl.registerLazySingleton(() => ScheduleCubit());

//Home ------ Notification

  sl.registerLazySingleton(() => NotificationCubit());

  ///Using object from dependency injection causing error
  ///when moving from deposit or withdraw to dashboard
  // sl.registerLazySingleton(() => DashboardCubit());
  //! cards.json

  sl.registerLazySingleton(() => CardsCubit(CardsSectionRepository.instance));
  sl.registerLazySingleton(() => CardLimitCubit());

  // request
  sl.registerLazySingleton(() => RequestCubit(sl()));
  sl.registerLazySingleton(() => RequestRemoteApi(sl()));
  sl.registerLazySingleton(() => RequestRemoteRepo(sl()));

  //! deposit
  sl.registerLazySingleton(() => DepositCubit());
  sl.registerLazySingleton(() => DepositRemoteApi());
  sl.registerLazySingleton(() => DepositRepo(sl()));

  //promotions
  sl.registerLazySingleton(() => PromotionsRepo(sl()));
  sl.registerLazySingleton(() => PromotionsApi());
  sl.registerLazySingleton(() => PromotionsCubit(sl()));

  //Country

  sl.registerLazySingleton(() => CountryTypeCubit());
  //! bank name
  sl.registerLazySingleton(() => BankNameCubit(sl()));
  sl.registerLazySingleton(() => BankNameRemoteApi(sl()));
  sl.registerLazySingleton<BankNameRemoteRepo>(() => BankNameRemoteRepo(sl()));

  //! category

  sl.registerLazySingleton<BaseCategoryApi>(() => JsonCategoryApi());
  sl.registerLazySingleton<CategoryRepo>(() => CategoryRepo(sl()));
  sl.registerLazySingleton<CategoryCubit>(() => CategoryCubit());
  //! amount

  sl.registerLazySingleton(() => TransactionAmountCubit());

  //! transfer

  sl.registerLazySingleton<BaseTransactionApi>(() => HistoryApi());
  sl.registerLazySingleton(() => TransactionHistoryRepo(sl()));
  sl.registerLazySingleton(() => TransactionHistoryCubit()..init());

  //Gift
  sl.registerLazySingleton(() => GiftCubit(sl()));
  sl.registerLazySingleton(() => GiftRemoteApi(sl()));
  sl.registerLazySingleton(() => GiftRepository(sl()));

  //More
  sl.registerLazySingleton(() => MoreCubit());
  sl.registerLazySingleton(() => MoreLocalApi());
  sl.registerLazySingleton(() => MoreRepo(sl()));

  ///all needed setup
  await initApp();
  //! transaction type


  sl.registerLazySingleton(() => TransactionTypeRepository());
  sl.registerSingleton<TransactionTypeCubit>(TransactionTypeCubit());

  //! analytics
  sl.registerLazySingleton<BaseAnalyticsApi>(() => RemoteAnalyticsApi());
  sl.registerLazySingleton(() => AnalyticsRepo(sl()));

  ///analytics
  sl.registerLazySingleton(() => AnalyticsCubit(sl()), instanceName: 'user');
  sl.registerLazySingleton(() => AnalyticsCubit(sl(), isAuthorized: false),
      instanceName: 'guest');

  /// bill pay
  sl.registerLazySingleton(() => BillRepo());
  sl.registerLazySingleton(() => BillCubit(sl()));

  //beneficiary
  sl.registerLazySingleton(() => BeneficiaryCubit(sl(), sl()));
  sl.registerLazySingleton(() => BeneficiaryRemoteApi(sl()));
  sl.registerLazySingleton(() => BeneficiaryRemoteRepo(sl()));

  //! budget
  sl.registerLazySingleton<BaseBudgetApi>(() => RemoteBudgetApi());
  sl.registerLazySingleton(() => BudgetRepo(sl()));
  sl.registerLazySingleton(() => BudgetCubit()..loadBudget());

  //! Profile
  sl.registerLazySingleton(() => ProfileCubit(sl()));

  // referral
  sl.registerLazySingleton(() => ReferralCubit());
  sl.registerLazySingleton(() => RemoteReferralApi());
  sl.registerLazySingleton(() => RemoteReferralApiRepo(sl()));

  //--------celebrity------//

  sl.registerLazySingleton<BaseCelebrityApi>(() => RemoteCelebrityApi());
  sl.registerLazySingleton(() => CelebrityRepo(sl()));
  sl.registerLazySingleton(() => CelebrityCubit(sl()));

  //! support
  sl.registerLazySingleton(() => SupportCubit(sl()));
  sl.registerLazySingleton(() => SupportRemoteApi(sl()));
  sl.registerLazySingleton(() => SupportRepository(sl()));

  // Saving
  sl.registerLazySingleton(
      () => SavingCubit(RoleRepository.instance, SavingRepository.instance));
  // sl.registerLazySingleton(() => SavingRepository());

  ///profile
  sl.registerLazySingleton(() => ProfileRepository(sl()));
  sl.registerLazySingleton(() => ProfileAPI(sl()));

  ///withdraw
  sl.registerLazySingleton(() => WithdrawRepository());

  // Language
  sl.registerLazySingleton(
      () => LanguageRepository(languageAPI: LanguageAPI.instance));

  // // Privacy
  // sl.registerLazySingleton(() => PrivacyCubit());
  //
  // // About
  // sl.registerLazySingleton(() => AboutCubit());
  //
  // // Terms
  // sl.registerLazySingleton(() => TermsCubit());
  //WithdrawCubit
  sl.registerLazySingleton(() => WithdrawCubit());

  //! orders
  sl.registerLazySingleton<BaseOrdersApi>(() => RemoteOrdersApi());
  sl.registerLazySingleton(() => OrdersRepo(sl()));
  sl.registerLazySingleton(() => OrdersCubit(sl()));

  //! customer loyalty
  sl.registerLazySingleton(() => CustomerLoyaltyApi());
  sl.registerLazySingleton(() => CustomerLoyaltyRepo(sl()));
  sl.registerLazySingleton(() => CustomerLoyaltyCubit());

  //! e_commerce
  sl.registerLazySingleton(() => ECommerceCubit());

  //! store detail
  sl.registerLazySingleton(() => StoreDetailCubit(sl()));
  sl.registerLazySingleton(() => RemoteStoreDetailRepo(sl()));
  sl.registerLazySingleton(() => StoreDetailApi());

  // Shipping location
  sl.registerLazySingleton(
      () => ShippingLocationCubit(ShippingLocationRepository.instance));

  // Cart
  sl.registerLazySingleton(() => CartCubit(sl()));
  sl.registerLazySingleton(() => CartApi());
  sl.registerLazySingleton(() => RemoteCartRepo(sl()));

  // Favourite
  sl.registerLazySingleton(() => FavoriteCubit(sl()));
  sl.registerLazySingleton(() => RemoteFavoriteRepo(sl()));
  sl.registerLazySingleton(() => FavouriteApi());

  sl.registerLazySingleton(() => ShopCubit());
  sl.registerLazySingleton(() => HomCubit());

  ///shop
  sl.registerLazySingleton(() => ShopRepo());

  //checkout
  sl.registerLazySingleton(() => CheckoutCubit());
}
