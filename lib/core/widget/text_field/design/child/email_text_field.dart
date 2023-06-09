import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/parent/parent.dart';
import 'package:res_pay_merchant/core/widget/text_field/validator/child/email_validator.dart';

class EmailTextField extends StatelessWidget {
  final TextEditingController? emailController;
  final FocusNode? focusNode;
  final String? emailControllerError;
  final double? border;
  final bool? readOnly;
  final String? emailTitle;
  final String? emailHint;
  final Color? fillColor;
  final void Function()? onTab;
  final void Function(String) onChanged;

  const EmailTextField(
      {super.key,
      this.fillColor,
      this.onTab,
      this.readOnly,
      this.emailController,
      this.focusNode,
      this.emailControllerError,
      this.border,
      this.emailTitle = '',
      this.emailHint = '',
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    String? error = emailControllerError;
    return ParentTextField(
      readOnly: readOnly ?? false,
      borderRadius: border,
      title: tr(emailTitle!),
      controller: emailController,
      onTab: onTab,
      keyboardType: TextInputType.emailAddress,
      name: tr(emailHint!),
      validator: EmailValidator().getValidation(),
      focusNode: focusNode,
      onChanged: (String? v) {
        error = '';
        onChanged.call(v!);
      },
      hint: tr(emailHint!),
      error: error,
      fillColor: fillColor ?? Colors.white,
    );
  }
}
