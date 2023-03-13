import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/parent/parent.dart';
import 'package:res_pay_merchant/core/widget/text_field/validator/child/cvv_validator.dart';

class CvvTextField extends StatelessWidget {
  const CvvTextField({
    super.key,
    required this.onChanged,
    this.focusNode,
  });

  final ValueChanged<String> onChanged;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return ParentTextField(
      keyboardType: TextInputType.number,
      onChanged: onChanged,
      validator: CVVValidator().validation(),
      textInputFormatter: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
      ],
      fillColor: AppColors.backgroundColor,
      focusNode: focusNode,
      hint: tr("cvv_number"),
      title: tr('cvv'),
    );
  }
}
