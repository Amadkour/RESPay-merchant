import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/parent/parent.dart';

class NotesTextfield extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final bool isRequired;
  final TextEditingController? noteController;
  const NotesTextfield(
      {super.key,
      this.noteController,
      required this.onChanged,
      this.isRequired = true});

  @override
  Widget build(BuildContext context) {
    return ParentTextField(
      multiLine: 4,
      validator: (String? c) {
        if (isRequired) {
          if (c!.isEmpty) {
            return tr("Required");
          } else {
            return null;
          }
        } else {
          return null;
        }
      },
      controller: noteController,
      onChanged: onChanged,
      keyboardType: TextInputType.name,
      name: tr("notes"),
      title: tr("notes"),
      fillColor: AppColors.backgroundColor,
    );
  }
}
