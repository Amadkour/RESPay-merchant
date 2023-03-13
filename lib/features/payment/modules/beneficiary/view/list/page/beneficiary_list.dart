import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/dialogs/confitm_cancel_dialog.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/constants.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/controller/beneficiary_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/gift/view/page/send_gift_request.dart';
import 'package:res_pay_merchant/features/payment/modules/request/view/page/request_amount_page.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/constants.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/beneficary_model.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/shared/custom_app_bar_with_search_bar.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/transfer_to/add_new_beneficiary.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/transfer_to/beneficiary_item.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/transfer_to/build_tab_item.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class BeneficiaryList extends StatelessWidget {
  final ServiceType serviceType;
  final bool haveAppBar;

  const BeneficiaryList(
      {super.key, required this.serviceType, this.haveAppBar = true});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBarWidget: !haveAppBar
          ? const PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: CustomAppBarWithSearchBar(
                serviceType: ServiceType.transfer,
              ))
          : null,
      scaffold: Container(
        color: AppColors.lightWhite,
        padding: const EdgeInsets.all(20),
        child: BlocProvider<BeneficiaryCubit>.value(
          value: sl<BeneficiaryCubit>()
            ..getBeneficiary(serviceType: serviceType),
          child: BlocBuilder<BeneficiaryCubit, BeneficiaryState>(
            builder: (BuildContext context, BeneficiaryState state) {
              final BeneficiaryCubit beneficiary = sl<BeneficiaryCubit>();
              if (state is BeneficiaryLoadingState) {
                return const NativeLoading();
              }
              final List<Beneficiary> filtered =
                  beneficiary.filterBeneficiaries(serviceType);
              return SafeArea(
                top: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 5,
                    ),
                    AutoSizeText(tr('Transfer To'),
                        style: descriptionStyle.copyWith(
                          color: AppColors.blackColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 40,
                      child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(width: 1);
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                beneficiary.setCurrentTransferToTapIndex(index);
                              },
                              child: BuildTabItem(
                                width: 85,
                                  label: transferToOptions[index],
                                  isThisCurrentIndex: beneficiary
                                          .currentTransferCategoryTapIndex ==
                                      index),
                            );
                          },
                          itemCount: transferToOptions.length,
                          scrollDirection: Axis.horizontal),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            AddNewBeneficiary(serviceType: serviceType),
                            const SizedBox(height: 12),
                            ...List<Widget>.generate(
                              filtered.length,
                              (int index) {
                                return Slidable(
                                  key: ValueKey<int>(index),
                                  startActionPane:
                                  ActionPane(
                                    motion: const ScrollMotion(),

                                    children: <Widget>[
                                      SlidableAction(
                                        onPressed: (BuildContext c) {

                                          ConfirmCancelDialog(
                                              context: context,
                                              title: tr(
                                                  'sure_delete_Beneficiery'),
                                              onConfirm: () {
                                                beneficiary.deleteBeneficiary(index);

                                              });

                                        },
                                        backgroundColor: AppColors.blackColor,
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        label: 'Delete',
                                      ),

                                    ],
                                  ),
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(),

                                    children: <Widget>[
                                      SlidableAction(
                                        onPressed: (BuildContext c) {
                                          beneficiary.deleteBeneficiary(index);
                                        },
                                        backgroundColor: AppColors.blackColor,
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        label: 'Delete',
                                      ),

                                    ],
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      InkWell(
                                        key: Key("beneficiary_item_$index"),
                                        onTap: () {
                                          switch (serviceType) {
                                            case ServiceType.gift:
                                              //sl<GiftCubit>().setCurrentBeneficiary(filtered[index]);
                                              CustomNavigator.instance.push(
                                                routeWidget: SendGiftRequest(
                                                  beneficiary: filtered[index],
                                                  dialogSubTitle:
                                                      "Your gift request has been sent",
                                                  dialogTitle: "Gift Send",
                                                ),
                                              );
                                              break;
                                            case ServiceType.request_money:
                                              //sl<RequestCubit>().setCreatedBeneficiary(filtered[index]);
                                              CustomNavigator.instance.push(
                                                  routeWidget:
                                                      RequestAmountPage(
                                                beneficiary: filtered[index],
                                                dialogSubTitle:
                                                    "Your payment request has been sent",
                                                dialogTitle: "Request Send",
                                              ));
                                              break;
                                            default:
                                              //sl<BeneficiaryCubit>().setCreatedBeneficiary(filtered[index]);
                                              CustomNavigator.instance
                                                  .pushNamed(
                                                RoutesName.transferMoneyScreen,
                                                arguments: filtered[index],
                                              );
                                          }
                                        },
                                        child: BeneficiaryItem(
                                            imageRadius: 19,
                                            beneficiary: filtered[index]),
                                      ),
                                      const SizedBox(height: 12)
                                    ],
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
