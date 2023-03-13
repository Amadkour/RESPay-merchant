import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/widget/bottom_sheet/date_bottom_sheet.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/account_num_text_field.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/parent/parent.dart';
import 'package:res_pay_merchant/core/widget/text_field/validator/child/expire_date_validator.dart';

class ExpireDateTextField extends StatefulWidget {
  const ExpireDateTextField({
    super.key,
    required this.onChanged,
    required this.controller,
    this.date,
    required this.focusNode,
  });

  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final String? date;
  final FocusNode focusNode;

  @override
  State<ExpireDateTextField> createState() => _ExpireDateTextFieldState();
}

class _ExpireDateTextFieldState extends State<ExpireDateTextField> {
  @override
  void initState() {
    widget.focusNode.addListener(() {
      if (widget.focusNode.hasFocus) {
        showActiveDateSheet(
          context,
          (String v) {
            widget.onChanged(v);
          },
          widget.date,
        );
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ParentTextField(
      controller: widget.controller,
      readOnly: true,
      focusNode: widget.focusNode,
      keyboardType: TextInputType.number,
      textInputFormatter: <TextInputFormatter>[
        MaskedTextInputFormatter(
          mask: "##/####",
          separator: "/",
        ),
        FilteringTextInputFormatter.allow(RegExp(r'^\d+(\/\d+)*$'))
      ],
      onChanged: widget.onChanged,
      validator: ExpireDateValidator().validation(),
      fillColor: AppColors.backgroundColor,
      hint: "MM/YY",
      title: tr("valid_until"),
    );
  }
}
