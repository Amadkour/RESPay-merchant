import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/settings/modules/change_password/provider/repository/change_password_repository.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitial());

  /// ----------------------- Initialization ----------------------- ///
  /// ----- Keys
  GlobalKey<FormState> formKey = GlobalKey();

  /// ----- Controllers
  TextEditingController createController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController oldController = TextEditingController();

  /// ----- Focus Nodes
  FocusNode createFocusNode = FocusNode();
  FocusNode confirmFocusNode = FocusNode();
  FocusNode oldFocusNode = FocusNode();

  /// ----- Primitive variables
  bool createSecureText = true;
  // bool confirmSecureText = true;
  bool oldSecureText = true;

  ///--- Errors
  String oldPasswordError = "";
  String createPasswordError = "";
  String confirmPasswordError = "";

  ///--- Getters
  bool get enableButton {
    return formKey.currentState?.validate() ?? false;
  }

  /// ----------------------- Logic -------------------------------- ///

  void changeCreateSecureText() {
    createSecureText = !createSecureText;
    emit(ChangePasswordTogglePassword());
  }
  void updateOldScreen(String? v) {
    oldController.text=v??'';
    emit(ChangePasswordUpdateScreen());
  }
  void updateCreateScreen(String? v) {
    createController.text=v??'';
    emit(ChangePasswordUpdateScreen());
  }
  void updateConfirmScreen(String? v) {
    confirmController.text=v??'';
    emit(ChangePasswordUpdateScreen());
  }

  // void changeConfirmSecureText() {
  //   confirmSecureText = !confirmSecureText;
  //   emit(ChangePasswordTogglePassword());
  // }

  void changeOldSecureText() {
    oldSecureText = !oldSecureText;
    emit(ChangePasswordTogglePassword());
  }

  /// ----------------------- API Call
  Future<String> onTapButton({required VoidCallback onSuccess}) async {
    String message = "";
    emit(ChangePasswordLoading());
    try {

      (await ChangePasswordRepository.instance.changePasswordRepository(
              oldPassword: oldController.text.trim(),
              newPassword: createController.text.trim(),
              newPasswordConfirmation: confirmController.text.trim()))
          .fold((Failure l) {
        message = l.message;
        emit(ChangePasswordFailure());
      }, (String r) {
        message = 'Password Changed Successfully';
        onSuccess();
      });
    } catch (e) {
      message = 'Something went wrong';
      emit(ChangePasswordFailure());
    } finally {
      emit(ChangePasswordLoaded());
    }
    return message;
  }

  Future<String> submitForm({required VoidCallback onBack}) async {
    String message = "";
    if (formKey.currentState!.validate()) {
      if (createController.text.trim() == confirmController.text.trim()) {
        message = await onTapButton(onSuccess: () {
          onBack();
        });
      } else {

        confirmPasswordError = "must equal to new password";
        emit(ChangePasswordSubmitForm());
      }
    }

    return message;
  }
}
