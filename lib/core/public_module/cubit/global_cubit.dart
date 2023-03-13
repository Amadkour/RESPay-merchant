import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/local_storage_service.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/provider/model/logged_in_user_model.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit() : super(AppInitial());

  ///language
  Future<void> loadLanguage(String l) async {
    String translation;
    String errorTranslation;
    final String langFileName = l == 'ar' ? 'ar_AE' : 'en_US';
    translation =
        await rootBundle.loadString('assets/localization/$langFileName.json');
    errorTranslation =
        await rootBundle.loadString('assets/errors/$langFileName.json');
    localization = jsonDecode(translation) as Map<String, dynamic>;
    errorLocalization = jsonDecode(errorTranslation) as Map<String, dynamic>;
    await sl<LocalStorageService>().writeKey('lang', l);

    loggedInUser.locale = l;

    emit(LanguageChanged());
  }

  ///changeLang
  Future<void> changeTextField() async {
    emit(TextFieldChanged());
  }
}

String tr(String key, {bool isError = false}) {
  if (!isError) {
    return (localization[key] ?? key).toString();
  } else {
    return (errorLocalization[key] ?? key).toString();
  }
}

Map<String, dynamic> localization = <String, dynamic>{};
Map<String, dynamic> errorLocalization = <String, dynamic>{};

bool get isArabic => loggedInUser.locale == 'ar';
