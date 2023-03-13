import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/controller/beneficiary_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/controller/transfer_options/transfer_options_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/page/main_summary_page.dart';

class TransferTypePage extends StatelessWidget {
  const TransferTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    final BeneficiaryCubit beneficiaryCubit = sl<BeneficiaryCubit>();
    return DefaultTabController(
      length: 2,
      initialIndex: sl<BeneficiaryCubit>().currentTransferTypeTapIndex,
      child: BlocProvider<BeneficiaryCubit>.value(
        value: sl<BeneficiaryCubit>(),
        child: BlocBuilder<BeneficiaryCubit, BeneficiaryState>(
          builder: (BuildContext context, BeneficiaryState state) {
            final int tapIndex = sl<BeneficiaryCubit>().currentTransferTypeTapIndex;
            return MainScaffold(
              appBarWidget: const MainAppBar(
                title: "Add New Beneficiary",
              ),
              bottomNavigationBar: SafeArea(
                minimum: const EdgeInsets.all(12.0),
                child: LoadingButton(
                  key: transferDetailsLoadingButtonKey,
                  isLoading: false,
                  onTap: () {
                    if (beneficiaryCubit.isButtonEnabled()) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (tapIndex == 0) {
                          CustomNavigator.instance.push(
                              routeWidget: MainSummaryPage(
                                  currentSummaryPage: sl
                                      .get<TransferOptionsCubit>()
                                      .currentMethodType
                                      .buildWidgetSummary1()));
                        } else {
                          CustomNavigator.instance.push(
                              routeWidget: MainSummaryPage(
                            currentSummaryPage:
                                sl<TransferOptionsCubit>().currentMethodType.buildWidgetSummary2(),
                          ));
                        }
                        sl<BeneficiaryCubit>().resetToInitialState();
                      });
                    }
                  },
                  topPadding: 0,
                  title: "Add beneficiary",
                ),
              ),
              scaffold: Column(
                children: <Widget>[
                  sl.get<TransferOptionsCubit>().currentMethodType.numberOfTabs > 1
                      ? Material(
                          color: Colors.white,
                          child: TabBar(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            labelStyle:  TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.blackColor,
                            ),
                            unselectedLabelStyle:  TextStyle(
                              fontWeight: FontWeight.w400,
                              color: AppColors.blackColor,
                            ),
                            unselectedLabelColor: AppColors.grayTextColor,
                            labelColor: AppColors.blackColor,
                            indicatorColor: AppColors.blackColor,
                            onTap: (int value) {
                              sl<BeneficiaryCubit>().setCurrentTransferTapIndex(value);
                              sl<BeneficiaryCubit>().resetApiErrors();
                            },
                            tabs: <Widget>[
                              buildTabBarItem("International Transfer"),
                              buildTabBarItem("Local Transfer"),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                  Expanded(
                    child: TabBarView(
                      physics: sl.get<TransferOptionsCubit>().currentMethodType.numberOfTabs == 1
                          ? const NeverScrollableScrollPhysics()
                          : null,
                      children: <Widget>[
                        sl<TransferOptionsCubit>().currentMethodType.buildWidgetForTap1(),
                        sl<TransferOptionsCubit>().currentMethodType.buildWidgetForTap2(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String get getTransferType {
    return sl<BeneficiaryCubit>().currentTransferTypeTapIndex == 0 ? "external" : "internal";
  }

  Tab buildTabBarItem(String label) {
    return Tab(
      child: AutoSizeText(
        tr(label),
        maxLines: 1,
        minFontSize: 8,
      ),
    );
  }
}
