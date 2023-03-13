import 'package:auto_size_text/auto_size_text.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/public_module/focus_node_model.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/keyboard_actions_widget.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/confirm_password_text_field.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/date_text_field.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/email_text_field.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/id_text_field.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/name_text_field.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/password_text_field.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/phone_number_text_field.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/controller/login_cubit.dart';
import 'package:res_pay_merchant/features/authentication/modules/registration/controller/register_cubit.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class RegistrationView extends StatelessWidget {
  const RegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterCubit controller;
    return BlocProvider<RegisterCubit>(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocBuilder<RegisterCubit, RegisterState>(
        builder: (BuildContext context, RegisterState state) {
          controller = context.read<RegisterCubit>();
          return MainScaffold(
            scaffold: Scaffold(
              appBar: MainAppBar(
                title: tr('create Account'),
                backgroundColor: Colors.white,
              ),
              body: KeyboardActionsWidget(
                focusNodeModels: <FocusNodeModel>[
                  FocusNodeModel(focusNode: controller.fullNameFocusNode),
                  FocusNodeModel(focusNode: controller.idFocusNode),
                  FocusNodeModel(focusNode: controller.dateOfBirthFocusNode),
                  FocusNodeModel(focusNode: controller.phoneFocusNode),
                  FocusNodeModel(focusNode: controller.emailFocusNode),
                  FocusNodeModel(focusNode: controller.passwordFocusNode),
                  FocusNodeModel(focusNode: controller.confirmPasswordFocusNode),
                ],
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 24),
                    child: Form(
                      key: controller.formKey,
                      autovalidateMode: AutovalidateMode.disabled,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ///titles
                          AutoSizeText(
                            tr('Create your account'),
                            maxFontSize: 20,
                            minFontSize: 14,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.blackColor,
                              fontFamily: 'Bold',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ),
                          AutoSizeText(
                            tr('Complete your profile to continue to Res Pay app'),
                            maxFontSize: 14,
                            style: TextStyle(
                              height: 2,
                              color: AppColors.textColor3,
                              fontFamily: 'Plain',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),

                          ///first name
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: NameTextField(
                              minLength: 4,
                              key: registerFullNameTextFieldKey,
                              nameControllerError: controller.fullNameError,
                              hint: 'your Name',
                              title: 'Full Name',
                              focusNode: controller.fullNameFocusNode,
                              onChanged: controller.onChangeName,
                            ),
                          ),

                          ///id
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: IDTextField(
                              key: registerIDNumberTextFieldKey,
                              error: controller.idError,
                              idTitle: 'ID Number',
                              idHint: 'ID Number',
                              idFocusNode: controller.idFocusNode,
                              onChanged: controller.onChangeId,
                            ),
                          ),

                          ///birthdate
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: DateTextField(
                              focusNode: controller.dateOfBirthFocusNode,
                              key: registerDateTextFieldKey,
                              dateController: controller.birthDateController,
                              dateControllerError: controller.birthDateError,
                              dateTitle: 'Date Of Birth',
                              dateHint: 'DD/MM/YYYY',
                              onChanged: controller.onChangeDate,
                            ),
                          ),

                          ///phone number
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: PhoneNumberTextField(
                              key: registerPhoneNumberTextFieldKey,
                              error: controller.phoneError,
                              phoneTitle: 'Phone Number',
                              phoneNumberFocusNode: controller.phoneFocusNode,
                              onChanged: controller.onChangePhone,
                              phoneHint: 'Phone Number',
                            ),
                          ),

                          ///email
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: EmailTextField(
                                key: registerEmailTextFieldKey,
                                emailControllerError: controller.mailError,
                                focusNode: controller.emailFocusNode,
                                emailTitle: 'email',
                                emailHint: 'your email',
                                onChanged: controller.onChangeEmail),
                          ),

                          ///password
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: PasswordTextField(
                              key: registerPasswordTextFieldKey,
                              error: controller.passwordError,
                              securePasswordText: controller.transparentPassword,
                              passwordFocusNode: controller.passwordFocusNode,
                              changePasswordSecureTextState: () {
                                controller.onTabTransparentPassword();
                              },
                              passTitle: 'Create Password',
                              passHint: 'Password',
                              onChanged: controller.onChangePassword,
                            ),
                          ),

                          ///confirm password
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: ConfirmChangePasswordTextField(
                              key: registerConfirmPasswordTextFieldKey,
                              password: controller.password,
                              focusNode: controller.confirmPasswordFocusNode,
                              passwordControllerError: controller.confirmPasswordError,
                              secureText: controller.transparentPassword,
                              confirmPasswordSecureTextState: () {
                                controller.onTabTransparentPassword();
                              },
                              validateSecureTextState: (String val) {
                                return '';
                              },
                              hint: tr("password"),
                              name: tr("Confirmation Create PassWord"),
                              onChange: controller.onChangeConfirmPassword,
                            ),
                          ),

                          ///button
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: LoadingButton(
                                key: registerConfirmButtonKey,
                                isLoading: state is RegisterLoading,
                                title: 'register',
                                onTap: () async {
                                  FocusScope.of(context).unfocus();
                                  if (controller.buttonEnabled) {
                                    await _register(controller, context);
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _register(RegisterCubit registerCubit, BuildContext context) async {
    final Either<Failure, String> result = await registerCubit.register();
    result.fold((Failure l) => MyToast(tr('invalid_info')), (String r) {
      MyToast(r);
      CustomNavigator.instance.pushReplacementNamed(
        RoutesName.otp,
        argument: () async {
          ///Login with entered data in register
          ///after verifying phone to get logged in user
          ///from the server
          sl<LoginCubit>()
            ..tabIndex = 1
            ..idController.text = registerCubit.id!
            ..passwordController.text = registerCubit.password ?? ''
            ..onTapButton(
              onSuccess: () {
                CustomNavigator.instance.pushNamed(
                  RoutesName.setupPinCode,
                );
              },
            );
        },
      );
    });
  }
}
