import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
// import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/parent/parent.dart';
import 'package:res_pay_merchant/core/widget/text_field/validator/child/account_validator.dart';

class AccountNumText extends StatelessWidget {
  final TextEditingController? accountNumber;
  final String? accountNumberError;
  final FocusNode? focusNode;
  final String? title;
  final double? titleFontSize;
  final void Function(String)? onChanged;
  const AccountNumText({
    super.key,
    this.titleFontSize,
    this.accountNumber,
    this.focusNode,
    this.onChanged,
    this.accountNumberError,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    String? error = accountNumberError;
    return ParentTextField(
      onChanged: (String val) {
        if (onChanged != null) {
          onChanged!(val);
        } else {
          error = '';
        }
      },
      textInputFormatter: <MaskedTextInputFormatter>[
        MaskedTextInputFormatter(
          mask: '****-****-****-****-****-*****',
          separator: '-',
        ),
      ],
      maxLength: 30,
      controller: accountNumber,
      titleFontSize: titleFontSize,
      keyboardType: TextInputType.number,
      hint: "0000-0000-0000-0000-0000-00000",
      validator: AccountNumberValidator().validation(),
      title:
          title != null ? tr("Account Number/Address") : tr("Account NUMBER"),
      focusNode: focusNode,
      error: error,
    );
  }
}

class MaskedTextInputFormatter extends TextInputFormatter {
  final String? mask;
  final String? separator;

  MaskedTextInputFormatter({
    @required this.mask,
    @required this.separator,
  });

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty) {
      if (newValue.text.length > oldValue.text.length) {
        if (newValue.text.length > mask!.length) return oldValue;
        if (newValue.text.length < mask!.length &&
            mask![newValue.text.length - 1] == separator) {
          return TextEditingValue(
            text:
                '${oldValue.text}$separator${newValue.text.substring(newValue.text.length - 1)}',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            ),
          );
        }
      }
    }
    return newValue;
  }
}
