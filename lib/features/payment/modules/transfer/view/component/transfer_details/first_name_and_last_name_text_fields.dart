import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/name_text_field.dart';

class RowOfTwoTextFields extends StatelessWidget {
  final TextEditingController? firstTextFieldController;
  final TextEditingController? secondTextFieldController;
  final String secondTextFieldHint;
  final String firstTextFieldHint;
  final Function? firstTextFieldValidator;
  final Function? secondTextFieldValidator;
  final void Function()? onChanged;
  final ValueChanged<String?>? onFirstFieldChanged;
  final ValueChanged<String?>? onSecondFieldChanged;
  const RowOfTwoTextFields({
    super.key,
    required this.onChanged,
    this.secondTextFieldValidator,
    this.firstTextFieldValidator,
    this.firstTextFieldController,
    this.secondTextFieldController,
    required this.firstTextFieldHint,
    required this.secondTextFieldHint,
    this.secondTextFieldFocusNode,
    this.firstTextFieldFocusNode,
    this.onFirstFieldChanged,
    this.onSecondFieldChanged,
  });

  final FocusNode? firstTextFieldFocusNode;
  final FocusNode? secondTextFieldFocusNode;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Row(
        children: <Widget>[
          Expanded(
            child: NameTextField(
              errorMessage: "required",
              key: firstNameTextFieldKey,
              onChanged: (String value) {
                onFirstFieldChanged?.call(value);
                onChanged?.call();
              },
               minLength: 2,
              // isNumber: false,
              // titleFontSize: 12,
              title: "First Name",
              hint: "FName",
              nameController: firstTextFieldController,
              focusNode: firstTextFieldFocusNode,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: NameTextField(
              errorMessage: "required",
              key: lastNameTextFieldKey,
              onChanged: (String value) {
                onSecondFieldChanged?.call(value);
                onChanged?.call();
              },
              minLength: 2,
              // isNumber: false,
              // titleFontSize: 12,
              title: "Family Name",
              hint: "FmName",
              nameController: secondTextFieldController,
              focusNode: secondTextFieldFocusNode,
            ),
          ),
        ],
      ),
    );
  }
}
