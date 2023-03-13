import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/configuration/top_level_configuration.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/provider/model/logged_in_user_model.dart';
import 'package:res_pay_merchant/features/authentication/modules/registration/providers/models/register_inputs.dart';
import 'package:res_pay_merchant/features/authentication/modules/registration/providers/repository/registeration_repository.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit([RegistrationRepository? repo]) : super(RegisterInitial()) {
    _repo = repo ?? RegistrationRepository();
  }

  late RegistrationRepository _repo;

  ///use this controller to assign date from button sheet to text field
  final TextEditingController birthDateController = TextEditingController();

  ///users fields
  String? id;
  String? fullName;
  String? phone;
  String? email;
  String? password;
  String? passwordConfirmation;

  ///errors
  String fullNameError = '';
  String idError = '';
  String phoneError = '';
  String mailError = '';
  String birthDateError = '';
  String passwordError = '';
  String confirmPasswordError = '';

  bool transparentPassword = true;

  /// Focus Nodes
  FocusNode fullNameFocusNode = FocusNode();
  FocusNode idFocusNode = FocusNode();
  FocusNode dateOfBirthFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

  ///register form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool get buttonEnabled {
    return formKey.currentState?.validate() ?? false;
  }

  void onTabTransparentPassword() {
    transparentPassword = !transparentPassword;
    emit(PasswordTransparentChanged());
  }

  // bool transparentConfirmPassword = true;
  //
  // void onTabTransparentConfirmPassword() {
  //   transparentConfirmPassword = !transparentConfirmPassword;
  //   emit(ConfirmPasswordTransparentChanged());
  // }

  Future<Either<Failure, String>> register() async {
    emit(RegisterLoading());
    final RegisterInputs inputs = RegisterInputs(
      birthday: birthDateController.text,
      email: email,
      fullName: fullName,
      id: id,
      password: password,
      passwordConfirmation: passwordConfirmation,
      phone: phone,
    );
    final Either<Failure, String> result = await _repo.register(inputs);
    return result.fold((Failure l) {
      fullNameError = (l.errors['full_name'] ?? '').toString();
      birthDateError = (l.errors['dob'] ?? '').toString();
      phoneError = (l.errors['phone_number'] ?? '').toString();
      mailError = (l.errors['email'] ?? '').toString();
      idError = (l.errors['identity_id'] ?? '').toString();
      passwordError = (l.errors['password'] ?? '').toString();
      confirmPasswordError =
          (l.errors['password_confirmation'] ?? '').toString();
      emit(RegisterErrorState(l));
      return left(l);
    }, (String r) async {
      ///---caching user phone and id
      loggedInUser.phone = phone;
      loggedInUser.identityId = id;
      otp = r;
      //TODO  Remove In Production ---> log otp

      emit(RegisterLoaded());
      return right(r);
    });
  }

  ///onChange name
  void onChangeName(String value) {
    fullName = value;
    fullNameError = '';
    emit(RegisterInitial());
  }

  ///onChange id
  void onChangeId(String value) {
    id = value;
    idError = '';
    emit(RegisterInitial());
  }

  ///onChange phone
  void onChangePhone(String value) {
    phone = value;
    phoneError = '';
    emit(RegisterInitial());
  }

  ///onChange email
  void onChangeEmail(String value) {
    email = value;
    mailError = '';
    emit(RegisterInitial());
  }

  ///onChange date
  void onChangeDate() {
    birthDateError = '';
    emit(RegisterInitial());
  }

  ///onChange password
  void onChangePassword(String? value) {
    password = value;
    passwordError = '';
    emit(RegisterInitial());
  }

  ///onChange date
  void onChangeConfirmPassword(String? value) {
    passwordConfirmation = value;
    confirmPasswordError = '';
    emit(RegisterInitial());
  }
}
