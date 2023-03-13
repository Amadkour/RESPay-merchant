import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/local_storage_service.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/controller/hom_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/profile/provider/model/profile_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/profile/provider/repository/profile_repository.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/profile/view/component/picker_type.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileRepository? profileRepository;

  ProfileCubit(this.profileRepository) : super(ProfileInitial()) {
    _pickerType = PickerType();
    init();
  }
  final GlobalKey<FormState> profileValidationFormKey = GlobalKey<FormState>();

  bool get enableLoginButton {
    return profileValidationFormKey.currentState?.validate() ?? false;
  }

  File? image;
  void emitStateToUpdateTextFields() {
    emit(ProfileInitial());
  }

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController idNumberController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool enableButton(GlobalKey<FormState> profileValidationFormKey) {
    if (profileValidationFormKey.currentState != null) {
      return profileValidationFormKey.currentState!.validate();
    } else {
      return false;
    }
  }

  void updateState() {
    emit(ProfileInitial());
  }

  void updateIdNumber() {
    if (idError != "") {
      idError = "";
    }
    emit(ProfileInitial());
  }

  void updateEmail() {
    if (mailError != "") {
      mailError = "";
    }
    emit(ProfileInitial());
  }

  void updatePhone() {
    if (phoneError != "") {
      phoneError = "";
    }
    emit(ProfileInitial());
  }

  ///----- Focus Nodes
  FocusNode fullNameFocusNode = FocusNode();
  FocusNode idFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode mailFocusNode = FocusNode();
  FocusNode birthFocusNode = FocusNode();

  ///----- Errors
  String fullNameError = '';
  String idError = '';
  String phoneError = '';
  String mailError = '';
  String birthDateError = '';

  bool isSaveBottomSheet = false;
  bool isReadOnly = true;
  ProfileModel? profileModel;
  late PickerType _pickerType;

  /// normal methods (tested)
  void resetFormState() {
    isSaveBottomSheet = false;
    image = null;
  }

  void reset() {
    fullNameController.clear();
    idNumberController.clear();
    birthDateController.clear();
    phoneNumberController.clear();
    emailController.clear();
  }

  void resetErrors() {
    fullNameError = "";
    idError = "";
    phoneError = "";
    mailError = "";
    birthDateError = "";
  }

  void goToSaveMode() {
    isSaveBottomSheet = true;
    emit(IsSaveStateChanged());
  }

  void updateBirthDataState() {
    emit(ProfileUpdateBirthDateSate());
  }

  void cancel() {
    image = null;
    isSaveBottomSheet = false;
    isReadOnly = true;
    resetErrors();
    emit(IsSaveStateChanged());
  }

  void goToEditMode() {
    isSaveBottomSheet = false;
    emit(GoToEditMode());
  }

  void setCurrentIsReadOnlyState() {
    isReadOnly = !isReadOnly;
  }

  /// start method
  Future<void> init() async {
    try {
      isSaveBottomSheet = false;
      image = null;
      resetErrors();
      isReadOnly = true;
      profileModel = profileRepository!.data;
      fullNameController.text = profileModel!.fullName!;
      idNumberController.text = profileModel!.identityId.toString();
      birthDateController.text = profileModel!.dob!;
      phoneNumberController.text = profileModel!.phoneNumber!;
      emailController.text = profileModel!.email!;
      emit(ProfileLoaded());

    } catch (e) {
      emit(ProfileInitError());
    }
  }

  /// api calls
  Future<void> saveChanges() async {
    if (profileModel!.phoneNumber != phoneNumberController.text) {
      emit(PhoneNumberChanged());
    } else {
      await updateProfile();
    }
  }

  Future<void> updateProfile() async {
    resetErrors();
    emit(ProfileUpdateLoading());
    try {
      await sl<LocalStorageService>().writeSecureKey("already_opened", "true");
      (await sl<ProfileRepository>().updateProfileRepository(
        inputs: await ProfileModel(
                image: image != null
                    ? await MultipartFile.fromFile(
                        image!.path,
                        filename: image!.path.split('/').last,
                      )
                    : null,
                email: profileModel!.email == emailController.text ? null : emailController.text,
                phoneNumber:
                    profileModel!.phoneNumber == phoneNumberController.text ? null : phoneNumberController.text,
                identityId: idNumberController.text == profileModel!.identityId.toString()
                    ? null
                    : int.parse(idNumberController.text),
                dob: birthDateController.text == profileModel!.dob ? null : birthDateController.text,
                fullName: fullNameController.text == profileModel!.fullName ? null : fullNameController.text)
            .toJson(),
      ))
          .fold((Failure l) async {
        await sl<LocalStorageService>().setUserPhone(phoneNumberController.text);
        if (l.hint == "ACCOUNT NOT VERIFIED") {
          MyToast(l.errors["otp"].toString());
          sl<LocalStorageService>().writeSecureKey("verify_account_pin_code", l.errors["otp"].toString());
          CustomNavigator.instance.pushNamed(RoutesName.otp, arguments: () async {
            await executeSomeMethods();
            CustomNavigator.instance.pop();
          });
        }
        if (l.errors.isNotEmpty) {
          if (l.errors["error"] as String == "The identity id has been used before!") {
            idError = l.errors["error"] as String;
          }
          if (l.errors["error"] as String == "The phone number has been used before!") {
            phoneError = l.errors["error"] as String;
          }
          if (l.errors["error"] as String == "The email has been used before!") {
            mailError = l.errors["error"] as String;
          }
          emit(UpdateProfileErrorState());
        }
      }, (ParentModel response) async {
        if ((response as ProfileModel).message == "User Account Not Verified, verify your account first!") {
          CustomNavigator.instance.pushNamed(RoutesName.otp, arguments: () async {
            await executeSomeMethods();
            CustomNavigator.instance.pop();
          });
        } else {
          await executeSomeMethods();
        }
      });
    } catch (x) {
      emit(UpdateProfileErrorState());
    }
  }

  Future<void> executeSomeMethods() async {
    showProfile(toastMessage: tr("Profile Updated Successfully"));
    cancel();
    await sl<LocalStorageService>().writeSecureKey("already_opened", "false");
  }

  Future<void> showProfile({bool wantShowToast = true, String? toastMessage}) async {
    try {
      (await profileRepository!.showProfileRepository()).fold((Failure l) => null, (ParentModel r) {
        profileModel = r as ProfileModel;
        sl<HomCubit>().putNewDate();
        if(wantShowToast){
          MyToast(toastMessage!);
        }
        emit(ProfileLoaded());
      });
    } catch (e) {
      emit(ShowProfileErrorState());
    }
  }

  /// profile image method
  Future<String> onChangeImage() async {
    final File img = File((await _pickerType.showPickerTypeDialog())?.path ?? '');
    if (img.path != '') {
      final int bytes = img.readAsBytesSync().lengthInBytes;
      final double kb = bytes / 1024;
      if (kb > 2048) {
        MyToast("File Is Too Large ,Please Chose Another One");
      } else {
        image = img;
        emit(ImageChanged());
      }
      return '';
    } else {
      return 'select a valid image';
    }
  }

  void resetCubitState() {
    emit(ProfileInitial());
  }
}
