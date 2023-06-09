import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/parent/parent.dart';
import 'package:res_pay_merchant/core/widget/text_field/validator/child/id_validator.dart';

class IDTextField extends StatelessWidget {
  final TextEditingController? idController;
  final FocusNode? idFocusNode;
  final String? idTitle;
  final String? idHint;
  final bool? readOnly;
  final String? error;
  final double? fullWidth;
  final double? titleFontSize;
  final Color? fillColor;
  final void Function()? onTab;
  final void Function(String)? onChanged;

  const IDTextField({
    super.key,
    this.idController,
    this.idFocusNode,
    this.idTitle = '',
    this.readOnly,
    this.idHint = '',
    this.onTab,
    this.fillColor,
    this.error,
    this.fullWidth,
    this.titleFontSize,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ParentTextField(
      controller: idController,
      error: error,
      onChanged: (String? value) {
        onChanged!.call(value!);
      },
      onTab: onTab,
      readOnly: readOnly ?? false,
      titleFontSize: titleFontSize,
      fillColor: fillColor ?? Colors.white,
      validator: IDValidator().getValidation(),
      keyboardType: TextInputType.number,
      title: tr(idTitle!),
      hint: tr(idHint!),
      hintFontSize: fullWidth == null ? null : fullWidth! / 30,
      focusNode: idFocusNode,
    );
  }
}
