import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/controller/transfer_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/beneficary_model.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class BeneficiaryActivatePage extends StatelessWidget {
  const BeneficiaryActivatePage({super.key, required this.beneficiary});
  final Beneficiary? beneficiary;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransferCubit>.value(
      value: sl<TransferCubit>(),
      child: MainScaffold(
        scaffold: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => CustomNavigator.instance.pop(numberOfPop: 4),
              icon: const Icon(Icons.close),
            ),
            title: Text(
              tr("activate_beneficiary"),
            ),
            centerTitle: false,
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 50, top: 30),
                  child: MyImage.svgAssets(
                    url: "assets/icons/transfer/activate_beneficiary.svg",
                  ),
                ),
                AutoSizeText(
                  tr("you_need_activate"),
                  style: headlineStyle,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 36, left: 20, right: 20),
                  child: Text(
                    tr("activate_beneficiary_description"),
                    style: descriptionStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 30,
                  ),
                  child: LoadingButton(
                    key: callMeNowButtonKey,
                    isLoading: false,
                    onTap: () {
                      CustomNavigator.instance.pushNamed(
                          RoutesName.beneficiaryActivated,
                          arguments: beneficiary);
                    },
                    title: tr("call_me_now"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 85, bottom: 19),
                  child: AutoSizeText(
                    tr("other_method"),
                    style: descriptionStyle,
                  ),
                ),
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          offset: const Offset(
                            -4.5,
                            -12,
                          ),
                          color: const Color.fromRGBO(38, 38, 38, 1)
                              .withOpacity(0.01),
                        )
                      ],
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.greenColor,
                      )),
                  padding: const EdgeInsets.all(10),
                  child: MyImage.svgAssets(
                    url: "assets/icons/transfer/smartphone.svg",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30, top: 10),
                  child: Text(
                    tr("res_pay_phone"),
                    style: headlineStyle.copyWith(
                      fontSize: 12,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
