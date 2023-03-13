import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
import 'package:res_pay_merchant/core/configuration/top_level_configuration.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/local_storage_service.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/provider/model/logged_in_user_model.dart';
import 'package:res_pay_merchant/features/authentication/modules/pin_code/provider/repo/pin_code_repo.dart';
import 'package:res_pay_merchant/features/authentication/modules/pin_code/view/page/fingerprint_page.dart';
part 'pin_code_state.dart';

class PinCodeCubit extends Cubit<PinCodeState> {
  PinCodeCubit(
      {LocalStorageService? service,
      LocalAuthentication? auth,
      PinCodeRepo? repo})
      : super(PinCodeInitial()) {
    _localStorageService = service ?? sl<LocalStorageService>();
    _localAuth = auth ?? LocalAuthentication();
    _repo = repo ?? PinCodeRepo();
    numberList = <String>['1', '2', '3', '4', '5', '6', '7', '8', '9'];
  }

  bool? setup;
  Future<String?> Function()? onSuccess;
  late LocalStorageService _localStorageService;
  late LocalAuthentication _localAuth;
  late PinCodeRepo _repo;
  List<BiometricType> availableBiometrics = <BiometricType>[];
  bool canAddNumber = true;
  late String pinCode;

  void deletePinCode() {
    pinCode = pinCode.substring(0, pinCode.length - 1);
    emit(PinCodeChanged(pinCode));
  }

  Future<void> onAddKeyboard(BuildContext context, String key) async {
    try {
      ///text config
      if (canAddNumber) {
        pinCode += key;
      } else {
        pinCode = key;
        canAddNumber = true;
      }
      emit(PinCodeChanged(pinCode));

      ///on type 4 digits
      if (pinCode.length == 4) {
        emit(PinCodeLoading());
        canAddNumber = false;

        ///if setup pin code
        if (setup ?? false) {
          if (authenticateType != 0) {
            CustomNavigator.instance.push(routeWidget: const FingerprintPage());
          } else {
            await onDoneWithoutBiometric();
          }
        } else {
          /// check correction pin code
          if (pinCode == loggedInUser.pinCode) {
            if (onSuccess != null) {
              await onSuccess!();
              // await onSuccess!().whenComplete(() {
              //   Future<dynamic>.delayed(
              //       const Duration(milliseconds: 150), () => emit(PinCodeLoaded()));
              // });
            }
          } else {
            MyToast('Error Pin Code, Please Enter The Correct Code');
          }
          emit(PinCodeLoaded());
        }
      }
    } catch (e) {
      emit(PinCodeFailure());
      MyToast("Error: ${e.toString()}");
    }
  }

  String code = '';
  late Future<void> Function(String code) function;
  List<String> numberList = <String>[];

  int authenticateType = 0;

  Future<void> init(
      {bool? setup, Future<String?> Function()? onSuccess}) async {
    this.setup = setup;
    this.onSuccess = onSuccess;
    pinCode = '';
    bool canAuth = false;

    final bool canAuthenticateWithBiometrics =
        await _localAuth.canCheckBiometrics;

    canAuth =
        canAuthenticateWithBiometrics || await _localAuth.isDeviceSupported();
    availableBiometrics = await _localAuth.getAvailableBiometrics();
    _faceIdEnabled = _localStorageService.getUserFaceId;
    _fingerPrintEnabled = _localStorageService.getUserTouchId;

    if (canAuth) {
      if (hasFaceId) {
        authenticateType = 2;
      } else if (hasFingerPrintId) {
        authenticateType = 1;
      } else {
        authenticateType = 0;
      }
    } else {
      authenticateType = 0;
    }

    emit(PinCodeInitial());
  }

  Future<void> onDoneWithoutBiometric() async {
    emit(PinCodeOnDoneLoading());
    final String cachedOtp = (pinCode.isNotEmpty
            ? pinCode
            : await _localStorageService.getUserPinCode) ??
        "";
    final Either<Failure, bool> result = await _repo.setup(cachedOtp, 0, 0);
    result.fold((Failure l) {
      emit(PinCodeError(l));
    }, (bool r) async {
      try {
        await _localStorageService.setFaceIdValue(faceId: false);
        _faceIdEnabled = false;
        await _localStorageService.setTouchIdValue(touchId: false);
        _fingerPrintEnabled = false;
        await _localStorageService.setUserPinCode(pinCode);
        loggedInUser.pinCode = pinCode;
        pinCode = '';
        await onSuccess?.call();
        emit(PinCodeLoaded());
      } catch (e) {
        emit(PinCodeError(GeneralFailure(message: e.toString())));
      }
    });
  }

  Future<void> onDoneWithBiometric() async {
    emit(PinCodeOnDoneWithBiometricsLoading());
    final String cachedOtp = (pinCode.isNotEmpty
            ? pinCode
            : await _localStorageService.getUserPinCode) ??
        "";
    final Either<Failure, bool> result = await _repo.setup(cachedOtp, 1, 1);
    result.fold((Failure l) {
      emit(PinCodeError(l));
    }, (bool r) async {
      try {
        await _localStorageService.setFaceIdValue(faceId: true);
        _faceIdEnabled = true;
        await _localStorageService.setTouchIdValue(touchId: true);
        _fingerPrintEnabled = true;
        await _localStorageService.setUserPinCode(pinCode);
        loggedInUser.pinCode = pinCode;
        pinCode = '';
        await onSuccess?.call();
        emit(PinCodeLoaded());
      } catch (e) {
        emit(PinCodeError(GeneralFailure(message: e.toString())));
      }
    });
  }

  Future<bool> onOpenSinger() async {
    isLocalAuth = true;

    final bool didAuthenticate = await _localAuth.authenticate(
        localizedReason: 'Biometric',
        authMessages: <AuthMessages>[
          AndroidAuthMessages(
            signInTitle: 'Oops! Biometric authentication required!',
            cancelButton: tr('notNow'),
          ),
          IOSAuthMessages(
            cancelButton: tr('notNow'),
          ),
        ]);
    isLocalAuth = false;
    return didAuthenticate;
  }

  bool get hasFaceId {
    return availableBiometrics.contains(BiometricType.face) ||
        availableBiometrics.contains(BiometricType.weak);
  }

  bool get hasFingerPrintId {
    return availableBiometrics.contains(BiometricType.fingerprint) ||
        availableBiometrics.contains(BiometricType.strong);
  }

  bool get faceIdEnabled => _faceIdEnabled;

  bool get fingerPrintEnabled => _fingerPrintEnabled;

  bool _faceIdEnabled = false;
  bool _fingerPrintEnabled = false;

  /// Send the Face ID new state to the api and change switcher value
  Future<void> setCurrentFaceId({required bool state}) async {
    emit(BioMetricLoading(2));

    final dynamic enabled = fingerPrintEnabled;

    /// change switcher variable first
    _faceIdEnabled = !_faceIdEnabled;
    emit(PinCodeInitial());

    final Either<Failure, bool> result = await _repo.setup(
        loggedInUser.pinCode ?? "", state ? 1 : 0, enabled == true ? 1 : 0);
    result.fold((Failure l) {
      /// get the previous state for the switcher if any error happened
      _faceIdEnabled = !_faceIdEnabled;
      emit(BiometricError(l));
    }, (bool r) async {
      try {
        await _localStorageService.setFaceIdValue(faceId: state);
        emit(BiometricChanged(value: state));
      } catch (e) {
        emit(BiometricError(GeneralFailure(message: e.toString())));
      }
    });
  }

  /// Send the Fingerprint new state to the api and change switcher value
  Future<void> setCurrentFingerPrint({required bool state}) async {
    emit(BioMetricLoading(1));
    final dynamic enabled = faceIdEnabled;

    /// change switcher variable first
    _fingerPrintEnabled = !_fingerPrintEnabled;
    emit(PinCodeInitial());
    final Either<Failure, bool> result = await _repo.setup(
        loggedInUser.pinCode ?? "", enabled == true ? 1 : 0, state ? 1 : 0);
    result.fold((Failure l) {
      /// get the previous state for the switcher if any error happened
      _fingerPrintEnabled = !_fingerPrintEnabled;
      MyToast(l.errors.toString());
      emit(PinCodeInitial());
    }, (bool r) async {
      try {
        await _localStorageService.setTouchIdValue(touchId: state);
        emit(BiometricChanged(value: state));
      } catch (e) {
        emit(BiometricError(GeneralFailure(message: e.toString())));
      }
    });
  }

  Future<void> onIntBiomatricPage() async {
    final bool authorized = await onOpenSinger();
    if (authorized) {
      onDoneWithBiometric();
    } else {
      MyToast(tr('unverified_user'));
    }
  }
}
