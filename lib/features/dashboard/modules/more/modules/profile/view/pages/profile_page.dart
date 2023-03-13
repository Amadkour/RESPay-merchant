import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/public_module/focus_node_model.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/dialogs/confitm_cancel_dialog.dart';
import 'package:res_pay_merchant/core/widget/keyboard_actions_widget.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/date_text_field.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/email_text_field.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/id_text_field.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/name_text_field.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/phone_number_text_field.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/profile/controller/profile_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/profile/view/component/edit_button_sheet.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/profile/view/component/user_image.dart';

class ProfilePage extends StatelessWidget {
  final GlobalKey<FormState> profileValidationFormKey;
  const ProfilePage({required this.profileValidationFormKey});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBarWidget: MainAppBar(backgroundColor: AppColors.backgroundColor, title: "My Profile"),
      scaffold: BlocProvider<ProfileCubit>.value(
        value: sl<ProfileCubit>(),
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (BuildContext context, ProfileState state) {
            final ProfileCubit profileCubit = sl<ProfileCubit>();
            if (state is ProfileCubitShowProfileLoading) {
              return const NativeLoading();
            }
            if (state is PhoneNumberChanged) {
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                ConfirmCancelDialog(
                    context: context,
                    titleWidget: Text.rich(
                      maxLines: 2,
                      TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: tr("are_you_sure_you_change_your_phone_number_to_be"),
                              style: TextStyle(
                                  fontSize: context.width * 0.04, fontWeight: FontWeight.w600)),
                          TextSpan(
                            text: " ${profileCubit.phoneNumberController.text}",
                            style: TextStyle(
                              color: AppColors.blueTextColor,
                              fontSize: context.width * 0.04,
                              decoration: TextDecoration.underline,
                            ),
                          )
                        ],
                      ),
                    ),
                    title:
                        "${tr("are_you_sure_to_change_your_phone_number_to_be")} ${profileCubit.phoneNumberController.text}?",
                    onConfirm: () async {
                      await profileCubit.updateProfile();
                    });
                profileCubit.resetCubitState();
              });
            }

            return KeyboardActionsWidget(
              focusNodeModels: !context.watch<ProfileCubit>().isSaveBottomSheet
                  ? <FocusNodeModel>[]
                  : <FocusNodeModel>[
                      FocusNodeModel(focusNode: profileCubit.fullNameFocusNode),
                      FocusNodeModel(focusNode: profileCubit.idFocusNode),
                      FocusNodeModel(focusNode: profileCubit.birthFocusNode),
                      FocusNodeModel(focusNode: profileCubit.phoneFocusNode),
                      FocusNodeModel(
                          focusNode: profileCubit.mailFocusNode,
                          onTap: () async {
                            await sl<ProfileCubit>().saveChanges();
                          }),
                    ],
              child: Container(
                padding: const EdgeInsets.all(20),
                color: AppColors.backgroundColor,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 230,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            ///image
                            UserImage(
                              image: profileCubit.image,
                              imageURL: profileCubit.profileModel!.imageUrl,
                              onChangeImage: () {
                                if (!profileCubit.isReadOnly) {
                                  profileCubit.onChangeImage();
                                }
                              },
                            ),

                            ///title
                            SizedBox(
                              height: 60,
                              child: Column(
                                children: <Widget>[
                                  AutoSizeText(
                                    profileCubit.profileModel!.fullName ?? '',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.w500),
                                    maxFontSize: 15,
                                    maxLines: 1,
                                    minFontSize: 8,
                                  ),
                                  AutoSizeText(profileCubit.profileModel!.email ?? '',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: AppColors.otpBorderColor,
                                          fontWeight: FontWeight.w400)),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),

                      ///details
                      Form(
                          key: profileValidationFormKey,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12.0),
                                child: NameTextField(
                                  minLength: 4,
                                  hint: 'your Name',
                                  nameController: profileCubit.fullNameController,
                                  focusNode: profileCubit.fullNameFocusNode,
                                  title: 'Full Name',
                                  readOnly: profileCubit.isReadOnly,
                                  nameControllerError: profileCubit.fullNameError,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12.0),
                                child: IDTextField(
                                  key: profileIdTextFieldKey,
                                  onChanged: (String v) {
                                    sl<ProfileCubit>().updateIdNumber();
                                  },
                                  idHint: 'YOUR ID',
                                  readOnly: profileCubit.isReadOnly,
                                  idTitle: 'ID Number',
                                  error: profileCubit.idError,
                                  idController: profileCubit.idNumberController,
                                  idFocusNode: profileCubit.idFocusNode,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12.0),
                                child: DateTextField(
                                  key: profileBirthDateTextFieldKey,
                                  readOnly: profileCubit.isReadOnly,
                                  dateController: profileCubit.birthDateController,
                                  onChanged: () {
                                    profileCubit.updateBirthDataState();
                                  },
                                  focusNode: profileCubit.birthFocusNode,
                                  dateControllerError: profileCubit.birthDateError,
                                  dateTitle: 'Date Of Birth',
                                  dateHint: 'DD/MM/YYYY',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12.0),
                                child: PhoneNumberTextField(
                                  onChanged: (String value) {
                                    profileCubit.updatePhone();
                                  },
                                  key: profilePhoneNumberTextFieldKey,
                                  readOnly: profileCubit.isReadOnly,
                                  phoneNumberController: profileCubit.phoneNumberController,
                                  phoneNumberFocusNode: profileCubit.phoneFocusNode,
                                  error: profileCubit.phoneError,
                                  phoneTitle: 'Phone Number',
                                  phoneHint: 'YOUR PHONE NUMBER',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12.0),
                                child: EmailTextField(
                                  key: profileEmailTextFieldKey,
                                  readOnly: profileCubit.isReadOnly,
                                  emailControllerError: profileCubit.mailError,
                                  emailController: profileCubit.emailController,
                                  focusNode: profileCubit.mailFocusNode,
                                  emailTitle: 'email',
                                  emailHint: 'your email',
                                  onChanged: (String v) {
                                    profileCubit.updateEmail();
                                  },
                                ),
                              ),
                            ],
                          )),
                      if (context.watch<ProfileCubit>().isSaveBottomSheet)
                        Column(
                          children: <Widget>[
                            SizedBox(
                              child: LoadingButton(
                                key: saveChangesProfileButtonKey,
                                topPadding: 0,
                                isLoading: state is ProfileUpdateLoading,
                                title: tr('Save Changes'),
                                enable: sl<ProfileCubit>().enableButton(profileValidationFormKey),
                                onTap: () async {
                                  await sl<ProfileCubit>().saveChanges();
                                },
                              ),
                            ),
                            SizedBox(
                              child: LoadingButton(
                                key: cancelProfileButtonKey,
                                isLoading: false,
                                title: tr('cancel'),
                                topPadding: 10,
                                backgroundColor: Colors.white,
                                fontColor: AppColors.primaryColor,
                                onTap: () async {
                                  sl<ProfileCubit>().cancel();
                                },
                              ),
                            )
                          ],
                        )
                      else
                        EditButtonSheet(
                          profileCubit: profileCubit,
                          profileState: state,
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
