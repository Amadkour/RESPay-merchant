import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';

import 'package:res_pay_merchant/core/widget/text_field/design/parent/parent.dart';

class ConfirmChangePasswordTextField extends StatelessWidget {
  final String? passwordControllerError;
  final FocusNode? focusNode;
  final bool? secureText;
  final bool havePrefix;
  final String? hint;
  final String? password;
  final String? name;
  final void Function() confirmPasswordSecureTextState;
  final void Function(String? v) onChange;
  final String Function(String val) validateSecureTextState;
  final TextEditingController? controller;
  const ConfirmChangePasswordTextField({
    super.key,
    this.passwordControllerError,
    required this.secureText,
    this.focusNode,
    this.hint,
    this.name,
    this.havePrefix = true,
    required this.confirmPasswordSecureTextState,
    required this.validateSecureTextState,
    required this.onChange,
    this.password,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ParentTextField(
      controller: controller,
      keyboardType: TextInputType.text,
      hint: hint ?? tr('type_new_password'),
      isPassword: secureText!,
      error: passwordControllerError,
      focusNode: focusNode,
      onChanged: onChange,
      title: name ?? '',
      suffix: secureText == null
          ? const SizedBox(
              width: 20,
            )
          : IconButton(
              key: showPasswordIconKey,
              icon: Icon(
                secureText!
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: AppColors.darkColor,
                size: 20,
              ),
              splashRadius: 1,
              onPressed: () {
                confirmPasswordSecureTextState();
              },
            ),
      validator: (String? val) {
        if (val!.isEmpty) return tr('password_empty');
        if (val != password) return tr('password_not_match');
        return null;
      },
    );
  }
}
