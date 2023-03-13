import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/configuration/top_level_configuration.dart';
import 'package:res_pay_merchant/core/constant/shared_orefrences_keys.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/local_storage_service.dart';
import 'package:res_pay_merchant/core/services/notification_service.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/provider/model/logged_in_user_model.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/provider/model/login_input.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/provider/repository/login_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  late final LoginRepository _loginRepository;
  late NotificationService service;

  LoginCubit(this._loginRepository, [NotificationService? service])
      : super(LoginControllerInitial()) {
    /// Get the app Language and pass it to the dropdown
    languageDropDownValue = sl<LocalStorageService>().readString('lang').isNotEmpty
        ? sl<LocalStorageService>().readString('lang')
        : Platform.localeName.split(".").first.split('_').first;

    ///initial values
    if (type == 'test' || type == 'integration test') {
      passwordController.text = 'Mobile@2022';
      idController.text = '20222022';
      phoneNumberController.text = '0585665655';
      emailController.text = 'mohamed1@gmail.com';
      tabIndex = 1;
    }
    this.service = service ?? sl<NotificationService>();
    Future<void>.delayed(const Duration(milliseconds: 1), () => emit(LoginControllerChanged()));
  }

  /// Initializations
  int tabIndex = 0;
  late String languageDropDownValue;

  bool isLoginLoading = false;
  bool securePassword = true;

  ///errors
  String idError = "";
  String phoneError = "";
  String passwordError = "";

  /// Login Screen
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode idFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode phoneNumberFocusNode = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool get enableLoginButton {
    return formKey.currentState?.validate() ?? false;
  }

  void emitStateToUpdateTextFields() {
    emit(LoginControllerEmitState(enable: enableLoginButton));
  }

  void onChangeTabIndex(int newIndex) {
    tabIndex = newIndex;

    emit(LoginControllerChangeTabIndexState(index: newIndex));
  }

  Future<void> changeLanguage(String value) async {
    languageDropDownValue = value;

    await sl<GlobalCubit>().loadLanguage(value);
    loggedInUser.locale = value;
    emit(LoginControllerChangeLanguageDropDownState(value: value));
  }

  void changeSecurePassword() {
    securePassword = !securePassword;
    emit(LoginControllerChangePasswordSecureTextState(enable: securePassword));
  }

  Future<String> onTapButton({required void Function() onSuccess}) async {
    String message = '';
    emit(LoginControllerIsLoginLoading());
    idError = "";
    phoneError = "";
    passwordError = "";
    final String fcmToken = await service.getDeviceToken();
    LoginInput input = LoginInput(
      password: passwordController.text,
      osType: Platform.isAndroid ? "andriod" : "ios",
      deviceToken: fcmToken,
    );
    try {
      Either<Failure, Map<String, dynamic>>? either;

      /// Login with phone Number
      if (tabIndex == 0) {
        await sl<LocalStorageService>()
            .writeSecureKey(userPhone, phoneNumberController.removeNonNumber);

        either = await _loginRepository
            .loginRepository(input.copyWith(phoneNumber: phoneNumberController.text));
      }

      /// Login with ID Number
      else if (tabIndex == 1) {
        await sl<LocalStorageService>().writeSecureKey(userId, idController.removeNonNumber);
        input = input.copyWith(
          identityId: idController.text,
        );
        either = await _loginRepository.loginRepository(input);
      }

      /// Login With Email
      else if (tabIndex == 2) {
        either =
            await _loginRepository.loginRepository(input.copyWith(email: emailController.text));
      }

      either!.fold((Failure l) {
        emit(LoginControllerFailure());

        /// Return errors to print them as MyToast in the UI
        if (l.errors['identity_id'] != null) {
          message = (l.errors['identity_id'] as List<dynamic>)[0].toString();
          idError = (l.errors['identity_id'] as List<dynamic>)[0].toString();
        } else if ((l.errors)['phone_number'] != null) {
          message = ((l.errors)['phone_number'] as List<dynamic>)[0].toString();
          phoneError = ((l.errors)['phone_number'] as List<dynamic>)[0].toString();
        } else if ((l.errors)['email'] != null) {
          message = ((l.errors)['email'] as List<dynamic>)[0].toString();
        } else {
          message = (l.errors)['error'].toString();
          passwordError = (l.errors)['error'].toString();
        }
      }, (Map<String, dynamic> response) async {
        ///----------------- If the user authenticated
        /// Store User data in the local storage
        final Map<String, dynamic> user =
            (response['data'] as Map<String, dynamic>)['user'] as Map<String, dynamic>;

        ///-----------store user data in shared dart model -------//
        loggedInUser = LoggedInUser.fromMap(user);
        await sl<LocalStorageService>().cacheCurrentUser(loggedInUser);

        // /// Save the language if the language key didn't remove
        // if (loggedInUser.locale == "en" || loggedInUser.locale == "ar") {
        //   print('loggedInUser.locale = ${loggedInUser.locale}');
        //
        //   await sl<LocalStorageService>().writeKey('lang', loggedInUser.locale);
        //
        //   print('labguage done = ${sl<LocalStorageService>().readString('lang')}');
        //
        // } else {
        //   /// Save the default value if the language key removed
        //   loggedInUser.locale =
        //       Platform.localeName.split(".").first.split('_').first;
        //   await sl<LocalStorageService>().writeKey('lang', loggedInUser.locale);
        // }

        /// Function to navigate to the next screen
        onSuccess();
      });
    } catch (e) {
      emit(LoginControllerFailure());
      message = tr('something_went_wrong');
    } finally {
      emit(LoginControllerIsLoginFinishLoading());
    }

    return message;
  }
}
