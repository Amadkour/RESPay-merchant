import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/public_module/focus_node_model.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/keyboard_actions_widget.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/password_text_field.dart';
import 'package:res_pay_merchant/features/authentication/view/component/auth_common_title.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/settings/modules/change_password/controller/change_password_cubit.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChangePasswordCubit>(
      create: (BuildContext context) => ChangePasswordCubit(),
      child: BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
        builder: (BuildContext context, ChangePasswordState state) {
          final ChangePasswordCubit cubit = BlocProvider.of<ChangePasswordCubit>(context);
          return MainScaffold(
            /// -------------------------------- AppBar -------------------------------- ///
            appBarWidget: MainAppBar(
              title: tr('change_password'),
            ),
            scaffold: KeyboardActionsWidget(
              focusNodeModels: <FocusNodeModel>[
                FocusNodeModel(focusNode: cubit.oldFocusNode),
                FocusNodeModel(focusNode: cubit.createFocusNode),
                FocusNodeModel(focusNode: cubit.confirmFocusNode),
              ],
              child: Padding(
                padding: EdgeInsets.only(
                    right: context.width * 0.05,
                    left: context.width * 0.05,
                    top: context.height * 0.055,
                    bottom: context.height * 0.05),
                child: SingleChildScrollView(
                  key: changePasswordListKey,
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: cubit.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        /// -------------------------------- Start text titles -------------------------------- ///
                        StartupTexts(
                          title: tr('change_your_password'),
                          subTitle: tr('password_limitation'),
                        ),

                        /// -------------------------------- Old Password text fields -------------------------------- ///
                        PasswordTextField(
                          key: oldPasswordTextFieldKey,
                          passwordFocusNode: cubit.oldFocusNode,
                          controller: cubit.oldController,
                          passHint: tr('password'),
                          passTitle: tr('old_password'),
                          securePasswordText: cubit.oldSecureText,
                          error: cubit.oldPasswordError,
                          changePasswordSecureTextState: cubit.changeOldSecureText,
                          onChanged: (String? value) {},
                        ),
                        SizedBox(
                          height: context.height * 0.03,
                        ),

                        /// -------------------------------- Create Password text fields -------------------------------- ///
                        PasswordTextField(
                          key: newPasswordTextFieldKey,
                          passwordFocusNode: cubit.createFocusNode,
                          controller: cubit.createController,
                          passHint: tr('password'),
                          passTitle: tr('new_password'),
                          securePasswordText: cubit.createSecureText,
                          error: cubit.createPasswordError,
                          changePasswordSecureTextState: cubit.changeCreateSecureText,
                          onChanged: (String? value) {},
                        ),
                        SizedBox(
                          height: context.height * 0.03,
                        ),

                        /// -------------------------------- Confirmation Password text fields -------------------------------- ///
                        PasswordTextField(
                          key: confirmNewPasswordTextFieldKey,
                          passwordFocusNode: cubit.confirmFocusNode,
                          controller: cubit.confirmController,
                          passHint: tr('password'),
                          error: cubit.confirmPasswordError,
                          passTitle: tr('confirm_new_password'),
                          securePasswordText: cubit.createSecureText,
                          changePasswordSecureTextState: cubit.changeCreateSecureText,
                          onChanged: (String? value) {},
                        ),
                        SizedBox(
                          height: context.height * 0.05,
                        ),

                        /// -------------------------------- Continue Button -------------------------------- ///
                        Center(
                          child: LoadingButton(
                            key: confirmChangePasswordButtonKey,
                            onTap: () async {
                              final String message = await cubit.submitForm(onBack: () {
                                CustomNavigator.instance.pop();
                              });
                              if (message.isNotEmpty) {
                                MyToast(message);
                              }
                            },
                            isLoading: state is ChangePasswordLoading,
                            topPadding: 0,
                            title: tr('confirm'),
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
