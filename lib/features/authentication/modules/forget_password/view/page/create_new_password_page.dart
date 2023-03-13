import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/confirm_password_text_field.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/password_text_field.dart';
import 'package:res_pay_merchant/features/authentication/modules/forget_password/controller/create_new_password/create_new_password_cubit.dart';
import 'package:res_pay_merchant/features/authentication/modules/forget_password/provider/repository/create_new_password_repository.dart';
import 'package:res_pay_merchant/features/authentication/view/component/auth_common_title.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class CreateNewPasswordPage extends StatelessWidget {
  final Map<String, dynamic> map;

  const CreateNewPasswordPage({super.key, required this.map});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateNewPasswordCubit>(
      create: (BuildContext context) =>
          CreateNewPasswordCubit(map, CreateNewPasswordRepository.instance),
      child: BlocBuilder<CreateNewPasswordCubit, CreateNewPasswordState>(
        builder: (BuildContext context, CreateNewPasswordState state) {
          final CreateNewPasswordCubit cubit = BlocProvider.of<CreateNewPasswordCubit>(context);
          return WillPopScope(
            onWillPop: () async {
              CustomNavigator.instance.popUntil(
                (Route<dynamic> route) => route.settings.name == RoutesName.login,
              );
              return false;
            },
            child: MainScaffold(
              appBarWidget: MainAppBar(
                title: 'Forgot Password',
                onBack: () {
                  CustomNavigator.instance.popUntil(
                    (Route<dynamic> route) => route.settings.name == RoutesName.login,
                  );
                },
              ),
              scaffold: Padding(
                padding: EdgeInsets.only(
                    right: context.width * 0.05,
                    left: context.width * 0.05,
                    top: context.height * 0.055,
                    bottom: context.height * 0.05),
                child: SingleChildScrollView(
                  key: createPasswordListKey,
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: cubit.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        /// -------------------------------- Start text titles -------------------------------- ///
                        const StartupTexts(
                          title: 'Create New Password',
                          subTitle:
                              'Password must contain 8-14 characters, at least 1 letter & 1 number.',
                        ),

                        /// -------------------------------- Create Password text fields -------------------------------- ///

                        PasswordTextField(
                          key: createNewPassTextFieldKey,
                          passwordFocusNode: cubit.createFocusNode,
                          passTitle: 'Create Password',
                          controller: cubit.createController,
                          passHint: tr('password'),
                          securePasswordText: cubit.createSecureText,
                          changePasswordSecureTextState: cubit.changeCreateSecureText,
                          onChanged: (String? v) {
                            cubit.updateScreen();
                          },
                        ),
                        SizedBox(
                          height: context.height * 0.05,
                        ),

                        /// -------------------------------- Confirmation Password text fields -------------------------------- ///
                        ConfirmChangePasswordTextField(
                          controller: cubit.confirmController,
                          key: confirmCreateNewPassTextFieldKey,
                          validateSecureTextState: (String val) {
                            return '';
                          },
                          hint: tr('password'),
                          name: 'Confirmation Create Password',
                          password: cubit.createController.text,
                          confirmPasswordSecureTextState: cubit.changeCreateSecureText,
                          secureText: cubit.createSecureText,
                          onChange: (String? v) {
                            cubit.updateScreen();
                          },
                        ),
                        SizedBox(
                          height: context.height * 0.2,
                        ),

                        /// -------------------------------- Continue Button -------------------------------- ///

                        Center(
                          child: LoadingButton(
                            key: confirmButtonCreateNewPasswordKey,
                            onTap: () async {
                              if (cubit.confirmController.text != cubit.createController.text) {
                                MyToast(tr(
                                    'The password field must match the password confirmation field'));
                              } else if (cubit.formKey.currentState!.validate()) {
                                final String message = await cubit.onTabButton(onSuccess: () {
                                  CustomNavigator.instance.pushNamed(RoutesName.login);
                                });
                                if (message.isNotEmpty) {
                                  MyToast(message);
                                }
                              }
                            },
                            enable: cubit.isEnable,
                            isLoading: state is CreateNewPasswordLoadingState,
                            topPadding: 0,
                            title: tr('continue'),
                          ),
                        ),
                      ],
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
}

class CreateNewPassword extends StatelessWidget {
  const CreateNewPassword({
    super.key,
    required this.state,
    required this.cubit,
    required this.buttonTitle,
  });

  final CreateNewPasswordCubit cubit;
  final CreateNewPasswordState state;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        CustomNavigator.instance.popUntil(
          (Route<dynamic> route) => route.settings.name == RoutesName.login,
        );
        return false;
      },
      child: MainScaffold(
        appBarWidget: MainAppBar(
          title: 'Forgot Password',
          onBack: () {
            CustomNavigator.instance.popUntil(
              (Route<dynamic> route) => route.settings.name == RoutesName.login,
            );
          },
        ),
        scaffold: Padding(
          padding: EdgeInsets.only(
              right: context.width * 0.05,
              left: context.width * 0.05,
              top: context.height * 0.055,
              bottom: context.height * 0.05),
          child: SingleChildScrollView(
            key: createPasswordListKey,
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: cubit.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  /// -------------------------------- Start text titles -------------------------------- ///
                  const StartupTexts(
                    title: 'Create New Password',
                    subTitle:
                        'Password must contain 8-14 characters, at least 1 letter & 1 number.',
                  ),

                  /// -------------------------------- Create Password text fields -------------------------------- ///

                  PasswordTextField(
                    key: createNewPassTextFieldKey,
                    passwordFocusNode: cubit.createFocusNode,
                    passTitle: 'Create Password',
                    controller: cubit.createController,
                    passHint: tr('password'),
                    securePasswordText: cubit.createSecureText,
                    changePasswordSecureTextState: cubit.changeCreateSecureText,
                    onChanged: (String? v) {
                      cubit.updateScreen();
                    },
                  ),
                  SizedBox(
                    height: context.height * 0.05,
                  ),

                  /// -------------------------------- Confirmation Password text fields -------------------------------- ///
                  ConfirmChangePasswordTextField(
                    controller: cubit.confirmController,
                    key: confirmCreateNewPassTextFieldKey,
                    validateSecureTextState: (String val) {
                      return '';
                    },
                    hint: tr('password'),
                    name: 'Confirmation Create Password',
                    password: cubit.createController.text,
                    confirmPasswordSecureTextState: cubit.changeCreateSecureText,
                    secureText: cubit.createSecureText,
                    onChange: (String? v) {
                      cubit.updateScreen();
                    },
                  ),
                  SizedBox(
                    height: context.height * 0.2,
                  ),

                  /// -------------------------------- Continue Button -------------------------------- ///

                  Center(
                    child: LoadingButton(
                      key: confirmButtonCreateNewPasswordKey,
                      onTap: () async {
                        if (cubit.confirmController.text != cubit.createController.text) {
                          MyToast(
                              tr('The password field must match the password confirmation field'));
                        } else if (cubit.formKey.currentState!.validate()) {
                          final String message = await cubit.onTabButton(onSuccess: () {
                            CustomNavigator.instance.pushNamed(RoutesName.login);
                          });
                          if (message.isNotEmpty) {
                            MyToast(message);
                          }
                        }
                      },
                      enable: cubit.isEnable,
                      isLoading: state is CreateNewPasswordLoadingState,
                      topPadding: 0,
                      title: tr('continue'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
