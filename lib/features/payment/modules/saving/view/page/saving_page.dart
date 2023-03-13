import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/controller/saving_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/view/component/activate_deactivate_saving_widget.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/view/component/add_new_role_widget.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/view/component/custom_total_saving_card.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/view/component/in_active_wallet_dialog.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/view/component/recent_activity_saving_list_widget.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/view/component/roles_list.dart';
import 'package:res_pay_merchant/features/payment/view/component/history_icon.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';

class SavingPage extends StatelessWidget {
  const SavingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SavingCubit>.value(
      value: sl<SavingCubit>()..init(),
      child: BlocBuilder<SavingCubit, SavingState>(
        builder: (BuildContext context, SavingState state) {
          final SavingCubit cubit = BlocProvider.of(context);
          return MainScaffold(
            appBarWidget: MainAppBar(
                title: tr('saving_money'), actions: const HistoryIconWidget()),
            scaffold: Builder(
              builder: (BuildContext context) {
                if (state is SavingLoadingState) {
                  return const NativeLoading();
                } else {
                  return SingleChildScrollView(
                    key: savingListKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ///--------------------------------------- Activate/Deactivate saving money ------------------------///
                        ActivateDeactivateSavingWidget(cubit: cubit),

                        SizedBox(
                          height: context.height * 0.03,
                        ),

                        ///--------------------------------------- Roles List ------------------------///
                        RolesList(cubit: cubit),
                        SizedBox(
                          height: context.height * 0.01,
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Column(
                            children: <Widget>[
                              ///--------------------------------------- Add new Role ------------------------///
                              AddNewRoleWidget(
                                cubit: cubit,
                              ),
                              SizedBox(
                                height: context.height * 0.05,
                              ),

                              ///--------------------------------------- Customized Total Saving Card ------------------------///
                              CustomTotalSavingCard(
                                totalMoney: cubit.totalMoney,
                                isSavingActive: cubit.activationWalletSwitcher,
                                savingNotActiveSheet: () {
                                  InActiveWalletDialog(
                                      context: context, cubit: cubit);
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),

                              ///--------------------------------------- Recent Activity ------------------------///

                              RecentActivitySavingListWidget(
                                cubit: cubit,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
