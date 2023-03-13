import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/parent/parent.dart';
import 'package:res_pay_merchant/core/widget/text_field/validator/child/money_amount_validator.dart';

class AmountTextField extends StatelessWidget {
  final String? initialText;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final void Function(String value)? onChanged;

  const AmountTextField({super.key, this.initialText, this.suffixIcon, this.onChanged, this.controller});

  @override
  Widget build(BuildContext context) {
    return ParentTextField(
      defaultValue: initialText,
      controller: controller,
      onChanged: onChanged,
      emitTextFieldChange: false,
      validator: MoneyAmountValidator().getValidation(),
      keyboardType: TextInputType.number,
      style: currencyFieldStyle,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.blackColor,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.blackColor,
          ),
        ),
        suffixIconConstraints: const BoxConstraints(
          maxWidth: 60,
          maxHeight: 40,
        ),
        suffixIcon: suffixIcon,
        hintText: "500",
        hintStyle: currencyFieldStyle.copyWith(
          color: AppColors.greyColor,
        ),
      ),
    );
  }
}
