import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/controller/transfer_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/beneficary_model.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/container_with_shadow_widget.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class BeneficiarySuccessfullyActivatedPage extends StatelessWidget {
  const BeneficiarySuccessfullyActivatedPage({super.key, this.beneficiary});
  final Beneficiary? beneficiary;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransferCubit>.value(
      value: sl<TransferCubit>(),
      child: MainScaffold(
        scaffold: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                CustomNavigator.instance.pop();
              },
              icon: const Icon(Icons.close),
            ),
            title: Text(
              tr("transfer"),
            ),
          ),
          bottomSheet: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                LoadingButton(
                  key: makeTransferButtonKey,
                  isLoading: false,
                  hasBottomSaveArea: false,
                  topPadding: 0,
                  onTap: () {
                    CustomNavigator.instance.pushNamed(
                      RoutesName.transferMoneyScreen,
                      arguments: beneficiary,
                    );
                  },
                  title: tr("make_transfer"),
                ),
                LoadingButton(
                  topPadding: 8,
                  isLoading: false,
                  onTap: () {
                    CustomNavigator.instance.pop(numberOfPop: 5);
                  },
                  title: tr("go_to_transfers"),
                  fontColor: Colors.black,
                  backgroundColor: Colors.white,
                  borderColor: AppColors.borderColor,
                ),
              ],
            ),
          ),
          body: Column(
            children: <Widget>[
              ContainerWithShadow(
                margin: const EdgeInsets.only(
                  top: 24,
                  left: 20,
                  right: 20,
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    SvgPicture.asset("assets/icons/transfer/success.svg"),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: AutoSizeText(
                        tr("successfully_activated"),
                        style: headlineStyle.copyWith(
                          color: AppColors.greenColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    BlocBuilder<TransferCubit, TransferState>(
                      bloc: sl<TransferCubit>(),
                      builder: (BuildContext context, Object? state) =>
                          AutoSizeText(
                        "${beneficiary?.fullName} Has Been \n ${tr("successfully_activated")}",
                        textAlign: TextAlign.center,
                        style: headlineStyle.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
