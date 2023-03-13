import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/controller/hom_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/history/controller/transaction_history_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transaction_types/controller/transaction_type_dart_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transaction_types/provider/model/transaction_type_model.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class WalletCard extends StatelessWidget {
  const WalletCard({super.key, required this.isAuthorized});

  final bool isAuthorized;

  @override
  Widget build(BuildContext context) {
    /// I Replace it with transaction history
    /// because data already loaded there
    return BlocBuilder<TransactionHistoryCubit, TransactionHistoryState>(
      builder: (BuildContext context, TransactionHistoryState state) {
        final TransactionHistoryCubit historyController =
            sl<TransactionHistoryCubit>();
        return Container(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const <BoxShadow>[
                BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1))
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (isAuthorized) ...<Widget>[
                AutoSizeText(
                  tr('Your Balance'),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textColor3,
                      fontFamily: 'Plain'),
                ),
                state is HomeLoading
                    ? const NativeLoading(
                        size: 30,
                      )
                    : state is HomeWalletError
                        ? ErrorWidget('error_in_wallet')
                        : Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 15),
                            child: FittedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  AutoSizeText(
                                    historyController.wallet?.total
                                            .toString() ??
                                        "0",
                                    style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.blackColor,
                                        fontFamily: 'Bold'),
                                  ),
                                  AutoSizeText(
                                    tr('SAR'),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.blackColor,
                                        fontFamily: 'Bold'),
                                  ),
                                ],
                              ),
                            ),
                          ),
              ],
              if (!isAuthorized) ...<Widget>[
                AutoSizeText(
                  tr('Your Balance'),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textColor3,
                      fontFamily: 'Plain'),
                ),
                state is HomeLoading
                    ? const NativeLoading(
                        size: 30,
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            AutoSizeText(
                              "0 ",
                              style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.blackColor,
                                  fontFamily: 'Bold'),
                            ),
                            AutoSizeText(
                              tr('SAR'),
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.blackColor,
                                  fontFamily: 'Bold'),
                            ),
                          ],
                        ),
                      ),
              ],
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      CustomNavigator.instance
                          .pushNamed(RoutesName.transferBeneficiaries);
                    },
                    child: Container(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: <Widget>[
                            MyImage.svgAssets(
                              url: 'assets/images/home/transfer.svg',
                              height: 16,
                              width: 16,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              tr('Transfer'),
                              style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.blackColor,
                                  fontFamily: 'semiBold'),
                            )
                          ],
                        )),
                  ),
                  SizedBox(
                      height: 12,
                      child: VerticalDivider(color: AppColors.blackColor)),
                  InkWell(
                    key: depositKey,
                    onTap: () => CustomNavigator.instance
                        .pushNamed(RoutesName.newDeposit),
                    child: Container(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: <Widget>[
                            MyImage.svgAssets(
                              url: 'assets/images/home/deposit.svg',
                              height: 16,
                              width: 16,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              tr('Deposit'),
                              style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.blackColor,
                                  fontFamily: 'semiBold'),
                            )
                          ],
                        )),
                  ),
                  SizedBox(
                      height: 12,
                      child: VerticalDivider(color: AppColors.blackColor)),
                  Container(
                      padding: const EdgeInsets.all(12),
                      child: InkWell(
                        key: datasheetKey,
                        onTap: () {
                          dateSheet(context);
                        },
                        child: Row(
                          children: <Widget>[
                            MyImage.svgAssets(
                              url: 'assets/images/home/more.svg',
                              height: 12,
                              width: 10,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              tr('More'),
                              style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.blackColor,
                                  fontFamily: 'semiBold'),
                            )
                          ],
                        ),
                      )),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

void dateSheet(
  BuildContext context,
) {
  showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 5),
                  child: Text(
                    tr('More'),
                    style: TextStyle(
                        fontSize: 20,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Center(
                    child: MyImage.svgAssets(
                  url: 'assets/images/moreBottomsheet/Rectangle.svg',
                  width: 64,
                  height: 5,
                )),
                const SizedBox(
                  height: 30,
                ),
                BlocProvider<TransactionTypeCubit>.value(
                  value: sl<TransactionTypeCubit>(),
                  child: Builder(builder: (BuildContext context) {
                    final List<TransactionTypeModel> types =
                        sl<TransactionTypeCubit>().types;
                    return GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5, mainAxisSpacing: 20),
                      shrinkWrap: true,
                      addRepaintBoundaries: false,
                      children: <Widget>[
                        ...List<Widget>.generate(
                          types.length,
                          (int index) {
                            return InkWell(
                                key: getDataSheetKey(
                                  types.elementAt(index).name.toLowerCase(),
                                ),
                                onTap: () {
                                  CustomNavigator.instance.pop();
                                  CustomNavigator.instance.pushNamed(
                                      types.elementAt(index).navigateTo);
                                },
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 44,
                                      width: 44,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xffF1F3F6)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: MyImage.svgAssets(
                                          url: types[index].icon,
                                          height: 24,
                                          width: 24,
                                        ),
                                      ),
                                    ),
                                    // const SizedBox(height: 10,),
                                    AutoSizeText(
                                      tr(types[index].name),
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'semiBold',
                                        color: Color(0xff2E3B4C),
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ));
                          },
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      });
}
