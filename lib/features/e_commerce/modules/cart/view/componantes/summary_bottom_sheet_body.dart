import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/controller/cart_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/view/componantes/row_of_title_with_price.dart';

class SummaryBody extends StatelessWidget {
  const SummaryBody(
      {super.key,
      this.onTapButton,
      this.buttonTitle,
      this.isLoadingButton = false,
      this.enable = true});

  final VoidCallback? onTapButton;
  final String? buttonTitle;
  final bool isLoadingButton;
  final bool? enable;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider<CartCubit>.value(
        value: sl<CartCubit>(),
        child: BlocBuilder<CartCubit, CartState>(
          builder: (BuildContext context, CartState state) {
            return Card(
              elevation: 100,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35))),
              child: AnimatedContainer(
                  height: sl<CartCubit>().showSummary ? 290 : 55,
                  padding: const EdgeInsets.only(
                      right: 20, left: 20, bottom: 10, top: 15),
                  duration: const Duration(milliseconds: 300),
                  child: Wrap(children: <Widget>[
                    InkWell(
                      key: showSummaryBottomSheet,
                      onTap: () {
                        sl<CartCubit>().setShowSummaryValue();
                      },
                      child: Container(
                        alignment: !sl<CartCubit>().showSummary
                            ? Alignment.center
                            : null,
                        child: AutoSizeText(tr("Summary"),
                            style: TextStyle(
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 16)),
                      ),
                    ),
                    sl<CartCubit>().showSummary
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: RowOfTitleWithPrice(
                                  title: tr("sub_total"),
                                  price: sl<CartCubit>()
                                      .cartModel!
                                      .cart!
                                      .subTotal!,
                                ),
                              ),
                              RowOfTitleWithPrice(
                                title: tr("tax"),
                                price: sl<CartCubit>().cartModel!.cart!.tax!,
                              ),
                              RowOfTitleWithPrice(
                                title: tr("shipment_fee"),
                                price:
                                    sl<CartCubit>().cartModel!.cart!.shipping!,
                              ),
                              RowOfTitleWithPrice(
                                title: tr("discount"),
                                price:
                                    sl<CartCubit>().cartModel!.cart!.discount!,
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                height: 1,
                                color: AppColors.blackColor.withOpacity(0.2),
                                width: double.infinity,
                              ),
                              RowOfTitleWithPrice(
                                title: tr("total"),
                                price: sl<CartCubit>().cartModel!.cart!.total!,
                              ),
                              Center(
                                  child: LoadingButton(
                                key: checkOutNowButton,
                                topPadding: 10,
                                isLoading: isLoadingButton,
                                onTap: onTapButton,
                                enable: enable!,
                                title: buttonTitle ?? tr('checkout_now'),
                              )),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ])),
            );
          },
        ),
      ),
    );
  }
}
