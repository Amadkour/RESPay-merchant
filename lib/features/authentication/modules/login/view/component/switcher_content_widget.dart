import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/email_text_field.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/id_text_field.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/password_text_field.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/phone_number_text_field.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/controller/login_cubit.dart';
/// Content of the slider within phone number,email and identity id
/// Part of [LoginPage]
class SwitcherContentWidget extends StatelessWidget {
  final int tabIndex;
  final FocusNode idFocusNode;
  final FocusNode phoneNumberFocusNode;
  final FocusNode passwordPhoneNumberFocusNode;
  final FocusNode? emailFocusNode;
  final TextEditingController passwordController;
  final TextEditingController idController;
  final TextEditingController? emailController;
  final TextEditingController phoneNumberController;
  final GlobalKey<FormState> formKey;
  final bool securePasswordPhoneNumberText;
  final void Function() changePasswordSecureText;
  final LoginCubit? cubit;
  final void Function() onChanged;

  const SwitcherContentWidget({
    super.key,
    required this.tabIndex,
    required this.idFocusNode,
    required this.phoneNumberFocusNode,
    required this.passwordPhoneNumberFocusNode,
    required this.passwordController,
    required this.idController,
    required this.phoneNumberController,
    required this.securePasswordPhoneNumberText,
    required this.changePasswordSecureText,
    this.emailFocusNode,
    this.emailController,
    required this.formKey,
    required this.onChanged,
    this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    ///-----------------------------  Phone Number  -----------------------------///
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (tabIndex == 0)
            PhoneNumberTextField(
              key: phoneNumberTextFieldKey,
              phoneNumberController: phoneNumberController,
              phoneHint: tr('phone_number'),
              onChanged: (String value) {
                cubit?.phoneError = '';
                onChanged();
              },
              fullWidth: context.width,
              titleFontSize: context.width * 0.03,
              phoneTitle: tr('phone_number'),
              error: cubit?.phoneError,
              onTab: () {
                FocusScope.of(context).unfocus();
                FocusScope.of(context).requestFocus(phoneNumberFocusNode);
              },
              phoneNumberFocusNode: phoneNumberFocusNode,
            ),
          if (tabIndex == 1)
            IDTextField(
              idController: idController,
              key: idControllerKey,
              idFocusNode: idFocusNode,
              onChanged: (String value) {
                cubit?.idError = '';
                onChanged();
              },
              idTitle: tr('id_number'),
              titleFontSize: context.width * 0.03,
              onTab: () {
                FocusScope.of(context).unfocus();
                idFocusNode.requestFocus();
              },
              error: cubit?.idError,
              idHint: tr('id_number'),
              fullWidth: context.width,
            ),
          if (tabIndex == 2)
            EmailTextField(
              emailController: emailController,
              focusNode: emailFocusNode,
              emailTitle: tr('email'),
              onTab: () {
                FocusScope.of(context).unfocus();
                FocusScope.of(context).requestFocus(emailFocusNode);
              },
              emailHint: tr('email'),
              onChanged: (String value) => onChanged(),
            ),
          const SizedBox(
            height: 10,
          ),
          PasswordTextField(
              key: passwordControllerKey,
              passwordFocusNode: passwordPhoneNumberFocusNode,
              securePasswordText: securePasswordPhoneNumberText,
              onChanged: (String? value) {
                passwordController.text = value ?? '';
                cubit?.passwordError = '';
                onChanged();
              },
              passTitle: tr('password'),
              error: cubit?.passwordError,
              titleFontSize: context.width * 0.03,
              passHint: tr('password'),
              onTab: () {
                FocusScope.of(context).unfocus();
                FocusScope.of(context).requestFocus(passwordPhoneNumberFocusNode);
              },
              fullWidth: context.width,
              changePasswordSecureTextState: changePasswordSecureText),
        ],
      ),
    );
  }
}
