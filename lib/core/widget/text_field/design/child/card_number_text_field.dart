import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/account_num_text_field.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/parent/parent.dart';
import 'package:res_pay_merchant/core/widget/text_field/validator/child/credit_card_validator.dart';

class CreditCardNumberTextField extends StatelessWidget {
  const CreditCardNumberTextField({
    super.key,
    required this.onChanged,
    this.focusNode,
  });
  final ValueChanged<String> onChanged;
  final FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    return ParentTextField(
      onChanged: onChanged,
      keyboardType: TextInputType.number,
      validator: CreditCardValidator().validation(),
      fillColor: AppColors.backgroundColor,
      focusNode: focusNode,
      textInputFormatter: <TextInputFormatter>[
        MaskedTextInputFormatter(
          mask: "****-****-****-****",
          separator: "-",
        ),
        FilteringTextInputFormatter.allow(RegExp('[0-9]|-'))
      ],
      hint: tr("card_number"),
      title: tr('card_number'),
    );
  }
}
