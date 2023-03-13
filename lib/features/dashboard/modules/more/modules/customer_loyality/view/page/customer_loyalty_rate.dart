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
import 'package:res_pay_merchant/core/widget/dialogs/custom_success_dialog.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/customer_loyality/controller/customer_loyalty_cubit.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class CustomerRate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
        scaffold: BlocProvider<CustomerLoyaltyCubit>.value(
            value: sl<CustomerLoyaltyCubit>(),
            child: BlocBuilder<CustomerLoyaltyCubit, CustomerLoyaltyState>(
                builder: (BuildContext context, CustomerLoyaltyState state) {
              final CustomerLoyaltyCubit controller = sl<CustomerLoyaltyCubit>();
              return Scaffold(
                appBar: MainAppBar(
                  title: tr('customer_loyalty'),
                  backgroundColor: Colors.white,
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        MyImage.network(
                          url: controller.selectedCustomerLoyalty?.icon,
                          height: 110,
                          width: 110,
                          borderRadius: 110,
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Text(
                          controller.selectedCustomerLoyalty?.title ?? "",
                          style: TextStyle(
                              fontSize: 20, color: AppColors.blackColor, fontFamily: 'Bold'),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          controller.selectedCustomerLoyalty?.description ?? "",
                          style: TextStyle(
                              fontSize: 14, color: AppColors.textColor3, fontFamily: 'Plain'),
                          textAlign: TextAlign.center,
                        ),
                        GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 6,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(12),
                                child: MyImage.svgAssets(
                                  url: (controller.selectedCustomerLoyalty?.rate ?? 0) <= index
                                      ? 'assets/images/star_off.svg'
                                      : 'assets/images/star_on.svg',
                                  height: 30,
                                  width: 30,
                                ),
                              );
                            }),
                        LoadingButton(
                          key: redeemKey,
                          title: 'redeem',
                          isLoading: state is RedeemCustomerLoyaltyLoading,
                          onTap: () async {
                            final String result = await controller.redeem();

                            await CustomSuccessDialog.instance.show(
                              title: result,
                              firstButtonText: tr('close'),
                              subTitle: '',
                              onPressedFirstButton: () {
                                CustomNavigator.instance.popUntil(
                                  (Route<dynamic> route) =>
                                      route.settings.name == RoutesName.customerLoyalty,
                                );
                              },
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              );
            })));
  }
}
