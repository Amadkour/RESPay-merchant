import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/parent/parent.dart';
import 'package:res_pay_merchant/core/widget/text_field/validator/child/empty_validation.dart';

class SimpleTextField extends StatelessWidget {
  const SimpleTextField(
      {super.key,
      required this.controller,
      required this.title,
      this.onChanged,
      required this.focusNode});

  final TextEditingController controller;
  final String title;
  final void Function(String)? onChanged;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return ParentTextField(
      validator: EmptyValidator().getValidationWithParameter(tr('required')),
      controller: controller,
      hint: tr('input'),
      onChanged: onChanged,
      focusNode: focusNode,
      title: title,
      fillColor: Colors.white,
    );
  }
}
