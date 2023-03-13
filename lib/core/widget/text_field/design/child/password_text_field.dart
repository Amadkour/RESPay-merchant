import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';

import 'package:res_pay_merchant/core/widget/text_field/design/parent/parent.dart';
import 'package:res_pay_merchant/core/widget/text_field/validator/child/password_validator.dart';

class PasswordTextField extends StatelessWidget {
  final FocusNode? passwordFocusNode;

  final bool securePasswordText;
  final void Function() changePasswordSecureTextState;

  final String? passTitle;
  final String? passHint;
  final String? error;
  final double? fullWidth;
  final double? titleFontSize;
  final TextEditingController? controller;
  final void Function()? onTab;
  final void Function(String?) onChanged;

  const PasswordTextField(
      {super.key,
      this.passwordFocusNode,
      required this.securePasswordText,
      required this.changePasswordSecureTextState,
      this.titleFontSize,
      this.error,
      this.passTitle = '',
      this.passHint = '',
      this.fullWidth,
      this.onTab,
      required this.onChanged,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return ParentTextField(
        isPassword: securePasswordText,
        error: error,
        titleFontSize: titleFontSize,
        controller: controller,
        onChanged: (String? value) {
          onChanged(value);
        },
        onTab: onTab,
        suffix: IconButton(
            key: showPasswordIconKey,
            icon: Icon(
              securePasswordText
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: AppColors.darkColor,
              size: 20,
            ),
            splashRadius: 1,
            onPressed: changePasswordSecureTextState),
        hintFontSize: fullWidth == null ? null : fullWidth! / 30,
        title: tr(passTitle!),
        hint: tr(passHint!),
        validator: PasswordValidator().getValidation(),
        focusNode: passwordFocusNode);
  }
}
