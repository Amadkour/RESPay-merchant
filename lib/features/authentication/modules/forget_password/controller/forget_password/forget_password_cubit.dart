import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/configuration/top_level_configuration.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/local_storage_service.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/authentication/modules/forget_password/provider/repository/forget_passwod_repository.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/provider/model/logged_in_user_model.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit(this._forgetPasswordRepository) : super(ForgetPasswordInitial());

  final ForgetPasswordRepository _forgetPasswordRepository;

  /// Controllers
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController idController = TextEditingController();

  /// Keys
  GlobalKey<FormState> phoneFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> idFormKey = GlobalKey<FormState>();

  /// FocusNodes
  FocusNode phoneFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode idFocusNode = FocusNode();

  /// booleans
  bool phoneExpanded = false;
  bool emailExpanded = false;
  bool idExpanded = false;

  ///----- Errors
  String emailError = '';
  String phoneError = '';
  String idError = '';

  ///-------------------------------- Getters
  /// Create that to return an error message if more than one text field have text
  int get numberOFTextFieldsHaveText {
    int count = 0;
    if (emailController.text.trim().isNotEmpty) count++;
    if (phoneController.text.trim().isNotEmpty) count++;
    if (idController.text.trim().isNotEmpty) count++;
    return count;
  }

  /// Choose Form key that have text to validate his textFields
  GlobalKey<FormState> get myFormKey {
    GlobalKey<FormState>? formKey;
    if (emailController.text.isNotEmpty) formKey = emailFormKey;
    if (phoneController.text.isNotEmpty) formKey = phoneFormKey;
    if (idController.text.isNotEmpty) formKey = idFormKey;

    return formKey!;
  }

  /// Return the submitted map when tap continue button
  Map<String, dynamic> get continueMap {
    return phoneController.text.trim().isNotEmpty
        ? <String, dynamic>{'phone_number': phoneController.text.trim()}
        : (idController.text.trim().isNotEmpty
            ? <String, dynamic>{'identity_id': idController.text.trim()}
            : <String, dynamic>{'email': emailController.text.trim()});
  }

  /// ------------------------------------- Logic
  /// Change the expansion card state for the phone card.
  void changePhoneExpansion() {
    phoneExpanded = !phoneExpanded;
    idExpanded = false;
    idController.clear();
    emit(ForgetPasswordExpand());
  }

  /// Change the expansion card state for the Email card.
  void changeEmailExpansion() {
    emailExpanded = !emailExpanded;
    emit(ForgetPasswordExpand());
  }

  /// Change the expansion card state for the id Number card.
  void changeIDNumberExpansion() {
    idExpanded = !idExpanded;
    phoneExpanded = false;
    phoneController.clear();
    emit(ForgetPasswordExpand());
  }

  void updateScreen() {
    emit(ForgetPasswordUpdateScreen());
  }

  /// Tab forget password, confirm identity id or phone number and send otp.
  Future<String> onTabButton({required void Function(String otp) onSuccess}) async {
    String message = '';

    try {
      emit(ForgetPasswordLoading());
      final Map<String, String> inputs = <String, String>{};

      if (idController.text.isNotEmpty) {
        inputs['identity_id'] = idController.text;
        loggedInUser.identityId = idController.text;
      }
      if (phoneController.text.isNotEmpty) {
        inputs['phone_number'] = phoneController.text;
        loggedInUser.phone = phoneController.text;
      }
      if (emailController.text.isNotEmpty) {
        inputs['email'] = emailController.text;
        loggedInUser.email = emailController.text;
      }

      (await _forgetPasswordRepository.forgotPasswordRepository(
        identifier: inputs,
      ))
          .fold((Failure l) {
        emit(ForgetPasswordFailure());

        if (l.errors['phone_number'] != null) {
          message = (l.errors['phone_number'] as List<String>)[0];
        } else if (l.errors['email'] != null) {
          message = (l.errors['email'] as List<String>)[0];
        } else if (l.errors['id_number'] != null) {
          message = (l.errors['id_number'] as List<String>)[0];
        } else {
          message = l.message;
        }
      }, (String r) async {
        ///bind identifier
        await sl<LocalStorageService>().writeSecureKey(inputs.keys.first, inputs.values.first);

        onSuccess(r);

        /// For integration test
        otp = r;
        MyToast(otp);
        emit(ForgetPasswordFinishLoading());
      });
    } catch (e) {
      emit(ForgetPasswordFailure());
      message = tr('something_went_wrong');
    } finally {
      emit(ForgetPasswordFinishLoading());
    }

    return message;
  }

  bool get isButtonEnable {
    if (idFormKey.currentState != null || phoneFormKey.currentState != null) {
      return idFormKey.currentState!.validate() || phoneFormKey.currentState!.validate();
    } else {
      return false;
    }
  }
}
