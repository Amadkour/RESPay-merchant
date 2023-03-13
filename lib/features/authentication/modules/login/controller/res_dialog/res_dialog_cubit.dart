import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/provider/repository/login_repository.dart';

part 'res_dialog_state.dart';

class ResDialogCubit extends Cubit<ResDialogState> {
  late final LoginRepository _loginRepository;

  ResDialogCubit({LoginRepository? loginRepositoryProvider})
      : super(ResDialogInitial()) {
    _loginRepository = loginRepositoryProvider ?? LoginRepository.instance;
  }

  /// ------------------------------------- Initialization -------------------------------- ///

  /// Primitive variables
  int tabIndex = 0;
  bool isLoading = false;
  int dialogTabIndex = 0;
  bool dialogSecurePasswordPhoneNumberText = true;
  bool dialogSecurePasswordIDNumberText = true;


  /// -------------------------------- Controllers
  final TextEditingController dialogPasswordPhoneNumberController =
      TextEditingController();
  final TextEditingController dialogPasswordIDNumberController =
      TextEditingController();
  final TextEditingController dialogIDController = TextEditingController();
  final TextEditingController dialogPhoneNumberController =
      TextEditingController();
  final FocusNode dialogPasswordPhoneNumberFocusNode = FocusNode();
  final FocusNode dialogIdFocusNode = FocusNode();
  final FocusNode dialogPhoneNumberFocusNode = FocusNode();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  /// toggle slider
  void changeTabIndex(int newIndex) {
    tabIndex = newIndex;
    emit(ResDialogChangeTabIndex());
  }

  /// Change visibility of password text in phoneNumber Tab in Res Login sheet
  void changeSecurePassword() {
    dialogSecurePasswordPhoneNumberText = !dialogSecurePasswordPhoneNumberText;
    emit(ResDialogChangeSecure());
  }

  /// Change visibility of password text in IDNumber Tab in Res Login sheet
  void changeSecureIDNumber() {
    dialogSecurePasswordIDNumberText = !dialogSecurePasswordIDNumberText;
    emit(ResDialogChangeSecure());
  }

  Future<void> resLoginWithIDNumber() async {
    try {
      emit(ResDialogLoading());
      final Map<String, dynamic> map = await _loginRepository.loginWithResRepository(
          password: dialogPasswordIDNumberController.text,
          identityId: dialogIDController.text);

      if (map['success'] as bool) {
        emit(ResDialogLoadingFinished());
      }
    } catch (e) {
      MyToast('Something went wrong');
      emit(ResDialogLoadingFinished());
    }
  }

  Future<void> resLoginWithPhoneNumber() async {
    try {
      emit(ResDialogLoading());
      final Map<String, dynamic> map = await _loginRepository.loginWithResRepository(
          password: dialogPasswordPhoneNumberController.text,
          phoneNumber: dialogPhoneNumberController.text);
      if (map['success'] as bool) {
        emit(ResDialogLoadingFinished());
      }
    } catch (e) {
      MyToast('Something went wrong');
      emit(ResDialogLoadingFinished());
    }
  }
}
