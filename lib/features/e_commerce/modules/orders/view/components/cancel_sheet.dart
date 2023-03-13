import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';

import 'package:res_pay_merchant/core/widget/text_field/design/child/description_text_field.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/controller/orders_cubit.dart';

class CancelSheet extends StatelessWidget {
  const CancelSheet({
    super.key,
    this.onChanged,
    required this.orderCubit,
    required this.formKey,
  });
  final ValueChanged<String>? onChanged;
  final OrdersCubit orderCubit;
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    final double bottomMargin = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(
          top: 20,
          bottom: bottomMargin > 150 ? bottomMargin - 160 : bottomMargin),
      child: Form(
        key: formKey,
        child: DescriptionTextfield(
          key: descriptionTextfieldKey,
          onChanged: (String v) {
            orderCubit.onCancelReasonChanged(v);
          },
        ),
      ),
    );
  }
}
