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
import 'package:res_pay_merchant/features/payment/modules/beneficiary/constants.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/controller/beneficiary_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/controller/transfer_options/transfer_options_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/beneficary_model.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class MainSummaryPage extends StatelessWidget {
  const MainSummaryPage({super.key, required this.currentSummaryPage});
  final Widget currentSummaryPage;

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBarWidget: MainAppBar(
          backgroundColor: AppColors.lightWhite, title: "New Beneficiary"),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          BlocProvider<BeneficiaryCubit>.value(
            value: sl<BeneficiaryCubit>(),
            child: BlocBuilder<BeneficiaryCubit, BeneficiaryState>(
              builder: (BuildContext context, BeneficiaryState state) {
                // if (state is BeneficiaryAddedInServer) {
                //
                // }
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
                  child: LoadingButton(
                    key: continueLoadingButtonKey,
                    title: "Confirm",
                    topPadding: 0,
                    isLoading: state is BeneficiaryLoadingState,
                    onTap: () async {
                      final Beneficiary? beneficiary =
                          await sl<BeneficiaryCubit>().addNewBeneficiary(
                              sl<TransferOptionsCubit>().currentMethodType);
                      if (beneficiary != null) {
                        CustomNavigator.instance.pushNamed(
                            RoutesName.activateBeneficiary,
                            arguments: beneficiary);
                        sl<BeneficiaryCubit>()
                            .getBeneficiary(serviceType: ServiceType.transfer);
                      }
                    },
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
            child: LoadingButton(
                isLoading: false,
                topPadding: 0,
                title: tr('cancel'),
                backgroundColor: Colors.white,
                fontColor: AppColors.primaryColor,
                onTap: () {
                  CustomNavigator.instance.pop();
                  //sl<BeneficiaryCubit>().cancelTransfer();
                }),
          )
        ],
      ),
      scaffold: currentSummaryPage,
    );
  }
}
