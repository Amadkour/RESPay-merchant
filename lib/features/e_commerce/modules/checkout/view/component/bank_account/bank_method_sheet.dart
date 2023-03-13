import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/checkout/controller/checkout_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/withdraw/controller/withdraw_cubit.dart';

class BankMethodSheet extends StatelessWidget {
  const BankMethodSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CheckoutCubit>.value(
      value: sl<CheckoutCubit>(),
      child: BlocBuilder<CheckoutCubit, CheckoutState>(
          builder: (BuildContext context, CheckoutState checkoutState) {
        return BlocProvider<WithdrawCubit>.value(
          value: sl<WithdrawCubit>(),
          child: BlocBuilder<WithdrawCubit, WithdrawState>(
            builder: (BuildContext context, WithdrawState withdrawState) {
              if (withdrawState is WithdrawLoading) {
                return const Center(
                  child: NativeLoading(),
                );
              } else {
                return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, int listIndex) {
                      return Container(
                        width: context.width * 0.35,
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              // color: Colors.black,
                              color: Color(0xffEFEFF2),
                              blurRadius: 10.0,
                            )
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: ColoredBox(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      MyImage.svgAssets(
                                        url:
                                            'assets/images/withdraw/bank_icon.svg',
                                        width: 32,
                                        height: 32,
                                      ),
                                      AutoSizeText(
                                        tr('card_number'),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(
                                                color: AppColors.textColor3,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          ...List<Widget>.generate(
                                              4,
                                              (int index) => Row(
                                                    children: <Widget>[
                                                      Container(
                                                        width: 5,
                                                        height: 5,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: AppColors
                                                              .blackColor,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 2.5,
                                                      )
                                                    ],
                                                  )),
                                          AutoSizeText(
                                            ' ${context.read<WithdrawCubit>().bankAccounts[listIndex].accountNumber!.substring(12, 16)}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1!
                                                .copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.blackColor,
                                                    fontSize: 12),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Radio<int>(
                                    value: listIndex,
                                    groupValue: context
                                        .watch<CheckoutCubit>()
                                        .selectedCardCheckout,
                                    onChanged: (int? value) {
                                      context
                                          .read<CheckoutCubit>()
                                          .toggleCard(value);
                                    },
                                    fillColor: MaterialStateProperty.all(
                                      AppColors.greenColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (_, int index) {
                      return const Material(
                        color: Colors.white,
                        child: SizedBox(
                          width: 15,
                        ),
                      );
                    },
                    itemCount:
                        context.read<WithdrawCubit>().bankAccounts.length);
              }
            },
          ),
        );
      }),
    );
  }
}
