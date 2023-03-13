import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/configuration/top_level_configuration.dart';
import 'package:res_pay_merchant/core/constant/shared_orefrences_keys.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/cubit/bloc_observer.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/public_module/provider/model/country.dart';
import 'package:res_pay_merchant/core/public_module/provider/model/country_list_model.dart';
import 'package:res_pay_merchant/core/public_module/provider/model/currency.dart';
import 'package:res_pay_merchant/core/public_module/provider/model/currency_list_model.dart';
import 'package:res_pay_merchant/core/public_module/provider/repos/currency_repo.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/firebase_options.dart';
import 'package:res_pay_merchant/core/services/local_storage_service.dart';
import 'package:res_pay_merchant/core/services/notification_service.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/provider/model/logged_in_user_model.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

Future<void> initApp() async {
  if (type == 'test') {
    Bloc.observer = MyBlocObserver();
  }

  ///orientation
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
  ]);

  final LocalStorageService localStorage =
      await sl<LocalStorageService>().init();
  await localStorage.writeSecureKey("already_opened", "false");
  if (await localStorage.containKey(appInstalled)) {
    ///auth
    if (await localStorage.containSecureKey(userToken)) {
      await _initLoggedInUser();

      ///have pin code
      if (loggedInUser.pinCode != null) {
        startRoute =
            type == 'test' ? RoutesName.authDashboard : RoutesName.pinCode;
      } else {
        startRoute = RoutesName.authDashboard;
      }
    } else {
      startRoute = RoutesName.onBoarding;
    }
  } else {
    await localStorage.removeAllSecureKeys();
    startRoute = RoutesName.onBoarding;
  }

  ///other configurations
  ///lang
  loggedInUser.locale = localStorage.readString('lang');
  if (!<String>['en', 'ar'].contains(loggedInUser.locale)) {
    loggedInUser.locale = Platform.localeName.split(".").first.split('_').first;
  }
  print("==================${loggedInUser.locale}");
  await sl<GlobalCubit>().loadLanguage(loggedInUser.locale ?? 'ar');

  ///country
  sl<CurrencyRepository>()
      .getCountries()
      .then((Either<Failure, ParentModel> value) {
    value.fold((Failure l) => null, (ParentModel r) {
      sl.registerLazySingleton<List<Country>>(
          () => (r as CountryListModel).countries);
    });
  });
  sl<CurrencyRepository>()
      .getCurrencies()
      .then((Either<Failure, ParentModel> value) {
    value.fold((Failure l) => null, (ParentModel r) {
      sl.registerLazySingleton<List<Currency>>(
          () => (r as CurrencyListModel).currencies);
    });
  });

  ///firebase
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform, name: 'dev_project');
  await sl<NotificationService>().initNotificationService();
  sl<NotificationService>().getDeviceToken();
}

/// This Function initialize logged in
///  user if it sets in local storage

Future<void> _initLoggedInUser() async {
  final LocalStorageService localStorageService = sl<LocalStorageService>();
  loggedInUser = LoggedInUser(
    name: localStorageService.getUserName,
    uuid: await localStorageService.getUserUUID,
    phone: await localStorageService.getUserPhone,
    isFaceIdActive: localStorageService.getUserFaceId,
    isTouchIdActive: localStorageService.getUserTouchId,
    identityId: await localStorageService.getUserId,
    pinCode: await localStorageService.getUserPinCode,
    token: await localStorageService.getUserToken,
    country: await localStorageService.getUserCountry,
    currency: await localStorageService.getUserCurrency,
  );
}
