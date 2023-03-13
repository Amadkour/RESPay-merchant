import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/public_module/provider/model/currency.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/parent/parent.dart';
import 'package:res_pay_merchant/core/widget/text_field/validator/child/money_amount_validator.dart';
import 'package:res_pay_merchant/features/payment/modules/amount/controller/transaction_amount_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/currency_drop_down_widget.dart';

class TransactionAmountTextField extends StatelessWidget {
  const TransactionAmountTextField({
    super.key,
    this.withCurrency = true,
    this.textAlign = TextAlign.start,
    this.label,
    this.isLocal = false,
    this.onChanged,
    this.controller,
    this.defaultValue,  this.autoFocus=false,
  });

  final ValueChanged<String>? onChanged;
  final bool withCurrency;
  final TextAlign textAlign;
  final TextEditingController? controller;
  final String? label;
  final String? defaultValue;
  final bool isLocal;
  final bool autoFocus;
  @override
  Widget build(BuildContext context) {
    //sl<TransactionAmountCubit>().amount = null;
    return BlocProvider<TransactionAmountCubit>.value(
      value: sl<TransactionAmountCubit>(),
      child: BlocBuilder<TransactionAmountCubit, TransactionAmountState>(
        builder: (BuildContext context, Object? state) {
          final TransactionAmountCubit amountCubit = context.read<TransactionAmountCubit>();
          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text(
                  tr(label ?? "enter_amount"),
                  style: descriptionStyle.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
              Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(
                    secondary: Colors.black,
                    primary: Colors.black,
                  ),
                ),
                child: ParentTextField(
                  key: key,
                  enableCopy: false,
                  autoFocus: autoFocus,
                  cursorWidth: 0,
                  maxLength: 5,
          textInputAction:TextInputAction.go,
                  onChanged: (String v) {
                    ///formatter
                    if (v.isNotEmpty && v[0] == '0') {
                      controller!.text = '';
                    }
                    if (v.length == 4) {
                      controller!.text = '${v[0]},${v.substring(1)}';
                    } else if (v.length == 5) {
                      controller!.text = '${v.substring(0, 2)},${v.substring(2)}';
                    } else if (v.length > 4) {
                      controller!.text = '${v.substring(0, 3)},${v.substring(
                        3,
                      )}';
                    }
                    ///action callback
                    controller!.selection =
                        TextSelection.fromPosition(TextPosition(offset: controller!.text.length));

                    if (onChanged != null) {
                      onChanged!.call(v);
                    } else {
                      amountCubit.onAmountChange.call(v);
                    }
                  },
                  textInputFormatter: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                  ],
                  validator: MoneyAmountValidator().getValidation(),
                  keyboardType: TextInputType.number,
                  style: currencyFieldStyle,
                  controller: controller,
                  textAlign: textAlign,
                  verticalPadding: 0,
                  padding: 0,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.blackColor.withOpacity(0.2),
                      ),
                    ),
                    suffixIconConstraints: const BoxConstraints(
                      maxWidth: 60,
                      maxHeight: 40,
                    ),
                    suffixIcon: withCurrency
                        ? CurrencyDropdown(
                            isLocal: isLocal,
                            onChanged: (Currency c) {
                              amountCubit.changeCurrency(c);
                            },
                            value: amountCubit.currentCurrency,
                          )
                        : const SizedBox(),
                    hintText: tr("0.00"),
                    hintStyle: currencyFieldStyle.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
