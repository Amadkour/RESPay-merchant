import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/parent/parent.dart';
import 'package:res_pay_merchant/core/widget/text_field/validator/child/money_amount_validator.dart';

class SavingRoleTextField extends StatelessWidget {
  const SavingRoleTextField(
      {super.key,
      required this.controller,
      required this.onChanged,
      required this.focusNode});
  final TextEditingController controller;
  final void Function(String? value) onChanged;
  final FocusNode focusNode;
  @override
  Widget build(BuildContext context) {
    return ParentTextField(
      validator: MoneyAmountValidator().getValidation(),
      keyboardType: TextInputType.number,
      focusNode: focusNode,
      controller: controller,
      emitTextFieldChange: false,
      onChanged: (String? value) {
        onChanged.call(value);
      },
      hint: tr('amount'),
      style: const TextStyle(fontWeight: FontWeight.bold),
      fillColor: AppColors.backgroundColor,
    );
  }
}
