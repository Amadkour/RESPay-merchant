import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/public_module/provider/model/currency.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';

import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/provider/model/logged_in_user_model.dart';
import 'package:res_pay_merchant/features/payment/modules/amount/controller/transaction_amount_cubit.dart';

class CurrencyDropdown extends StatelessWidget {
  const CurrencyDropdown({
    super.key,
    required this.onChanged,
    this.value,
    required this.isLocal
  });
  final Function(Currency) onChanged;
  final Currency? value;
  final bool isLocal;
  @override
  Widget build(BuildContext context) {
    return !isLocal? Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: AppColors.greenColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: BlocBuilder<TransactionAmountCubit, TransactionAmountState>(
        builder: (BuildContext context, TransactionAmountState state) {
          final TransactionAmountCubit countryListController = context.read<TransactionAmountCubit>();

          if (state is CurrencyLoadingState) {
            return const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(),
            );
          } else {
            return DropdownButton<Currency>(
              icon: RotatedBox(
                quarterTurns: 3,
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 13,
                  color: AppColors.greenColor,
                ),
              ),
              isExpanded: true,
              items: countryListController.currencies
                  .map(
                    (Currency e) => DropdownMenuItem<Currency>(
                      value: e,
                      child: AutoSizeText(
                        e.iso3Code,
                        style: descriptionStyle.copyWith(
                          color: AppColors.greenColor,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              value: value,
              underline: const SizedBox(),
              onChanged: (Currency? v) {
                onChanged(v!);
              },
            );
          }
        },
      )
    ):Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: AppColors.greenColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Center(
        child: AutoSizeText(
          maxLines: 1,
        (loggedInUser.currency??"").toUpperCase(),
        style: descriptionStyle.copyWith(
        color: AppColors.greenColor,
        )),
      ),
    );
  }
}
