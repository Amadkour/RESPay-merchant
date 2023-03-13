import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/alternative_widgets/coming_soon.dart';
import 'package:res_pay_merchant/core/widget/bottom_sheet/saving_bottom_sheets.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/controller/saving_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/view/component/divider_widget.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/view/component/image_and_icon_saving_card_widget.dart';

class CustomTotalSavingCard extends StatelessWidget {
  final double? totalMoney;
  final SavingState? state;
  final bool? isSavingActive;
  final void Function() savingNotActiveSheet;

  const CustomTotalSavingCard(
      {required this.isSavingActive,
      required this.savingNotActiveSheet,
      this.state,
      this.totalMoney});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SavingCubit>.value(
      value: sl<SavingCubit>(),
      child: BlocBuilder<SavingCubit, SavingState>(
        builder: (BuildContext context, SavingState state) {
          final SavingCubit cubit = BlocProvider.of(context);
          return Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: context.height * 0.011,
                  horizontal: context.width * 0.05),
              child: Column(
                children: <Widget>[
                  AutoSizeText(tr('total_saving')),
                  const SizedBox(
                    height: 5,
                  ),

                  /// -------------- Total Saving Amount ---------------- ///
                  AutoSizeText(
                    '${totalMoney!.toStringAsFixed(2)} ${tr('sar')}',
                    style:
                        paragraphStyle.copyWith(fontSize: context.width * 0.07),
                  ),
                  SizedBox(
                    height: context.height * 0.02,
                  ),

                  /// ---------------- Deposit, investing and withdraw row
                  Row(
                    children: <Widget>[
                      /// ---------------------- Add Money (Deposit) -------------------- ///
                      ImageAndIconSavingCardWidget(
                        key: depositSavingKey,
                        imageUrl: 'assets/images/home/deposit.svg',
                        title: tr('add_money'),
                        onTap: () {
                          /// Check first if the wallet is active
                          if (isSavingActive!) {
                            cubit.clearAmountController();
                            SavingBottomSheet(
                              context: context,
                              title: tr('add_money'),
                              availableBalance: totalMoney!,
                              subTitle: tr('please_enter_amount'),
                              blackButtonText: tr('add_money'),
                            );
                          } else {
                            /// if wallet is in active show the
                            /// inActive Dialog to activate wallet first
                            savingNotActiveSheet();
                          }
                        },
                      ),
                      const Spacer(),
                      const DividerWidget(),
                      const Spacer(),

                      /// ---------------------- Investing -------------------- ///

                      ImageAndIconSavingCardWidget(
                        key: investingSavingKey,
                        imageUrl: 'assets/icons/saving/withdraw-icon.svg',
                        title: tr('investing'),
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (_) => const ComingSoon());
                        },
                      ),
                      const Spacer(),
                      const DividerWidget(),
                      const Spacer(),

                      /// ---------------------- Withdraw -------------------- ///

                      ImageAndIconSavingCardWidget(
                        key: withdrawSavingKey,
                        imageUrl: 'assets/icons/saving/withdraw-icon.svg',
                        title: tr('withdraw'),
                        onTap: () {
                          /// Check first if the wallet is active
                          if (isSavingActive!) {
                            cubit.clearAmountController();
                            SavingBottomSheet(
                                context: context,
                                title: tr('withdraw'),
                                subTitle: tr('withdrawal_description'),
                                blackButtonText: tr('withdraw'),
                                availableBalance: totalMoney!);
                          } else {
                            /// if wallet is in active show the
                            /// inActive Dialog to activate wallet first
                            savingNotActiveSheet();
                          }
                        },
                      ),
                      const Spacer(),
                    ],
                  ),
                  SizedBox(
                    height: context.height * 0.02,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
