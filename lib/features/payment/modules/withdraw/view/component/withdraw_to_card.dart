import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/features/payment/modules/withdraw/controller/withdraw_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/withdraw/provider/model/bank_account.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class WithdrawToCard extends StatelessWidget {
  const WithdrawToCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WithdrawCubit, WithdrawState>(
      builder: (BuildContext context, WithdrawState state) {
        final WithdrawCubit controller = context.read<WithdrawCubit>();
        return controller.bankAccounts.isEmpty && state is WithdrawLoaded
            ? DottedBorder(
                color: AppColors.borderColor,
                dashPattern: const <double>[10, 5],
                radius: const Radius.circular(8),
                child: Container(
                  padding: const EdgeInsets.all(50),
                  child: Column(
                    children: <Widget>[
                      MyImage.svgAssets(
                        url: 'assets/images/withdraw/bank_icon.svg',
                        height: 48,
                        width: 48,
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      Text(
                        tr('No_bank'),
                        style: TextStyle(
                            color: AppColors.textColor3,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            fontFamily: 'Plain'),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      InkWell(
                        key: withdrawAddNewAccountKey,
                        onTap: () {
                          CustomNavigator.instance.pushNamed(
                            RoutesName.addBankAccount,
                            arguments: controller,
                          );
                        },
                        child: Text(
                          tr('Add_bank'),
                          style: TextStyle(
                            color: AppColors.blueTextColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            fontFamily: 'Plain',
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Column(
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      if (state is WithdrawLoading)
                        const NativeLoading()
                      else
                        ...List<Widget>.generate(
                            controller.bankAccounts.length,
                            (int index) => Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: AppColors.borderColor),
                                    ),
                                    child: ListTile(
                                      // leading: MyImage.svgAssets(url:controller.bankData![index].icon,height: 32,width: 32,),
                                      leading: MyImage.svgAssets(
                                        url:
                                            'assets/images/withdraw/rajhi_bank.svg',
                                        height: 32,
                                        width: 32,
                                      ),
                                      title: Text(
                                        controller
                                            .bankAccounts[index].bankName!,
                                        style: TextStyle(
                                            color: AppColors.blackColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            fontFamily: 'semiBold'),
                                      ),

                                      subtitle: Row(
                                        children: <Widget>[
                                          ///obscure text
                                          ...List<Widget>.generate(
                                              4,
                                              (int index) => Container(
                                                    margin:
                                                        const EdgeInsets.all(2),
                                                    height: 5,
                                                    width: 5,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: AppColors
                                                            .textColor3),
                                                  )),
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          ...List<Widget>.generate(
                                              4,
                                              (int index) => Container(
                                                    margin:
                                                        const EdgeInsets.all(2),
                                                    height: 5,
                                                    width: 5,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: AppColors
                                                            .textColor3),
                                                  )),
                                          const SizedBox(
                                            width: 3,
                                          ),

                                          ...List<Widget>.generate(
                                              4,
                                              (int index) => Container(
                                                    margin:
                                                        const EdgeInsets.all(2),
                                                    height: 5,
                                                    width: 5,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: AppColors
                                                            .textColor3),
                                                  )),
                                          const SizedBox(
                                            width: 3,
                                          ),

                                          Text(
                                            controller.bankAccounts[index]
                                                .accountNumber!
                                                .substring((controller
                                                            .bankAccounts[index]
                                                            .accountNumber!)
                                                        .length -
                                                    4),
                                            style: TextStyle(
                                                color: AppColors.blackColor,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                fontFamily: 'semiBold'),
                                          ),
                                        ],
                                      ),
                                      trailing: Radio<BankAccounts?>(
                                        key: Key('bank_check_key$index'),
                                        value: controller.bankAccounts
                                            .elementAt(index),
                                        groupValue:
                                            controller.selectedBankAccount,
                                        onChanged: controller.onChangeBank,
                                        hoverColor: AppColors.greenColor,
                                        activeColor: AppColors.greenColor,
                                      ),
                                    ),
                                  ),
                                )),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: InkWell(
                              key: withdrawAddNewAccountKey,
                              onTap: () {
                                CustomNavigator.instance.pushNamed(
                                  RoutesName.addBankAccount,
                                  arguments: controller,
                                );
                              },
                              child: DottedBorder(
                                color: AppColors.borderColor,
                                dashPattern: const <double>[10, 5],
                                radius: const Radius.circular(8),
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  child: Center(
                                    child: Text(
                                      tr('+ Add New'),
                                      style: TextStyle(
                                        color: AppColors.blueTextColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        fontFamily: 'Plain',
                                        decoration: TextDecoration.underline,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              );
      },
    );
  }
}
