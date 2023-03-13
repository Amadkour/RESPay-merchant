import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/shared_orefrences_keys.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/provider/model/logged_in_user_model.dart';
import 'package:res_pay_merchant/features/authentication/modules/otp/provider/repo/otp_repo.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit(this.function, this.fromAuth, [OtpRepo? repo])
      : super(OtpInitial()) {
    _repo = repo ?? OtpRepo();
    onInit();
  }

  late OtpRepo _repo;

  TextEditingController otpController = TextEditingController();
  String code = '';
  final Future<void> Function(String? code) function;
  late int start;
  late bool isLoading;
  void Function()? onBack;
  late Map<dynamic, dynamic> resendMap;
  List<String> numberList = <String>[];

  bool fromAuth = true;

  Future<void> onInit() async {
    ///------------Get previous page title to otp code Page
    isLoading = false;
    start = 59;
    numberList = <String>[
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '0',
      '00'
    ];
    otpController.addListener(() => emit(OtpInitial()));

    ///start
    startTimer();
  }

  late Timer _timer;

  void startTimer() {
    start = 59;
    const Duration oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          start = 59;
        } else {
          start--;
        }

        emit(state is OtpLoading ? OtpLoading() : OtpStartTime());
      },
    );
    emit(OtpStartTime());
  }

  Future<void> onTapConfirmButton() async {
    ///--------------hit api verification------------///
    emit(OtpLoading());
    final Either<Failure, String> result = await _repo.verify(<String, dynamic>{
      userPhone: loggedInUser.phone,
      userId: loggedInUser.identityId,
      "otp": otpController.text,
    });
    result.fold((Failure l) {
      emit(OtpError(l));
    }, (String r) async {
      _timer.cancel();
      await function.call(code);

      emit(OtpLoaded(r.isNotEmpty ? r : 'Loading'));
    });
  }

  Future<void> onChangeOtp() async {
    otpController.selection =
        TextSelection.collapsed(offset: otpController.text.length);
    if (otpController.text.length == 4 && state is! OtpLoading) {
      if (fromAuth) {
        await onTapConfirmButton();
      } else {
        await function.call(otpController.text);
      }
      otpController.clear();
    }
  }

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }
}
