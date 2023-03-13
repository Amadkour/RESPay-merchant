import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/authentication/modules/forget_password/provider/repository/create_new_password_repository.dart';

part 'create_new_password_state.dart';

class CreateNewPasswordCubit extends Cubit<CreateNewPasswordState> {
  CreateNewPasswordCubit(this.map, this._repository)
      : super(CreateNewPasswordInitial());

  final Map<String, dynamic> map;
  final CreateNewPasswordRepository _repository;

  /// Initializations
  final TextEditingController createController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  final FocusNode confirmFocusNode = FocusNode();
  final FocusNode createFocusNode = FocusNode();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool createSecureText = true;
  // bool confirmSecureText = true;

  /// Errors
  String createPasswordError = '';
  String confirmPasswordError = '';

  /// Change visibility of the create password text field.
  void changeCreateSecureText() {
    createSecureText = !createSecureText;
    emit(CreateNewPasswordChangeSecureState());
  }

  /// Change visibility of the Confirm password text field.
  // void changeConfirmSecureText() {
  //   confirmSecureText = !confirmSecureText;
  //   emit(CreateNewPasswordChangeSecureState());
  // }
  void updateScreen() {
    emit(CreateNewPasswordUpdateScreen());
  }

  /// Submit add a new password and confirm it
  Future<String> onTabButton({required VoidCallback onSuccess}) async {
    String message = '';

    try {
      emit(CreateNewPasswordLoadingState());

      map.addEntries(<MapEntry<String, String>>[
        MapEntry<String, String>('password', createController.text),
        MapEntry<String, String>(
            'password_confirmation', confirmController.text),
      ]);

      (await _repository.resetPasswordRepository(map: map)).fold((Failure l) {
        emit(CreateNewPasswordFailure());

        if ((l.errors['phone_number'] as List<String?>)[0] != null) {
          message = (l.errors['phone_number'] as List<String?>)[0].toString();
        } else if ((l.errors['identity_id'] as List<String?>)[0] != null) {
          message = (l.errors['identity_id'] as List<String?>)[0].toString();
        } else {
          message = l.message;
        }
        if (l.errors.isNotEmpty) {
          createPasswordError = (l.errors['password'] == null ||
                  (l.errors['password'] as List<dynamic>).isEmpty)
              ? ''
              : (l.errors['password'] as List<String>)[0];
          confirmPasswordError = (l.errors['password_confirmation'] == null ||
                  (l.errors['password_confirmation'] as List<dynamic>).isEmpty)
              ? ''
              : (l.errors['password_confirmation'] as List<String>)[0];
        }
      }, (Map<String, dynamic> r) async {
        onSuccess();
        message = 'Password Changed Successfully';
      });
    } catch (e) {
      emit(CreateNewPasswordFailure());
    } finally {
      emit(CreateNewPasswordLoadingFinishedState());
    }
    return message;
  }

  bool get isEnable {
    if(formKey.currentState!=null){
      return formKey.currentState!.validate();
    }
    else{
      return false;
    }
  }
}
