import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/parent/parent.dart';
import 'package:res_pay_merchant/core/widget/text_field/validator/child/description_validation.dart';

class DescriptionTextfield extends StatelessWidget {
  const DescriptionTextfield({
    super.key,
    this.onChanged,
  });
  final ValueChanged<String>? onChanged;
  @override
  Widget build(BuildContext context) {
    return ParentTextField(
      validator: DescriptionValidation().getValidation(),
      onChanged: onChanged,
      title: tr('description'),
      multiLine: 5,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.borderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: context.theme.primaryColor,
          ),
        ),
      ),
    );
  }
}
