import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';

import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';

import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/parent/parent.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/controller/cart_cubit.dart';

import 'package:res_pay_merchant/core/res/theme/colors.dart';

import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';

class DiscountCodeTextField extends StatefulWidget {
  final String shopUUID;
  const DiscountCodeTextField({super.key, required this.shopUUID});

  @override
  State<DiscountCodeTextField> createState() => _DiscountCodeTextFieldState();
}

class _DiscountCodeTextFieldState extends State<DiscountCodeTextField> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CartCubit>().resetPromoCode();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(10),
          strokeWidth: 1.1,
          dashPattern: const <double>[10, 7],
          color: const Color(0xffDDD9C4),
          strokeCap: StrokeCap.square,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Container(
              width: double.infinity,
              // height: 50,
              color: const Color(0xffFDFAE9),
              child: Center(
                child: ParentTextField(
                  key: discountCodeTextField,
                  borderRadius: 10,
                  focusNode: sl<CartCubit>().promoCodeFocusNode,
                  fillColor: const Color(0xffFDFAE9),
                  suffix: BlocProvider<CartCubit>.value(
                    value: sl<CartCubit>(),
                    child: BlocBuilder<CartCubit, CartState>(
                      builder: (BuildContext context, CartState state) {
                        if (state is CartPromotionsLoading) {
                          return Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 2),
                              width: 65,
                              height: 20,
                              child: const NativeLoading(
                                size: 25,
                              ));
                        }
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          width: 65,
                          child: LoadingButton(
                            key: checkOrRemovePromoCodeButton,
                            height: 30,
                            topPadding: 0,
                            backgroundColor: AppColors.blackColor,
                            borderColor: AppColors.blackColor,
                            isLoading: state is CartPromotionsLoading,
                            fontWeight: FontWeight.w500,
                            onTap: () async {
                              if (!await sl<CartCubit>()
                                  .setIsPromotion(widget.shopUUID)) {
                                MyToast(tr("promo_code_field_is_empty"));
                              }
                            },
                            title: sl<CartCubit>().isPromoCodeApplied
                                ? "Remove"
                                : "check",
                          ),
                        );
                      },
                    ),
                  ),
                  hint: tr("enter_the_discount_code"),
                  hintStyle: const TextStyle(
                      color: Color(0xff5A6367),
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                  prefix: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(width: 11),
                      SizedBox(
                        width: 22,
                        height: 24,
                        child: RotatedBox(
                          quarterTurns: -1,
                          child: MyImage.svgAssets(
                            url: "assets/icons/e_commerce/discount.svg",
                          ),
                        ),
                      ),
                    ],
                  ),
                  controller: sl<CartCubit>().promotionTextFieldController,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          context.watch<CartCubit>().cartModel!.cart!.discount != 0
              ? context.watch<CartCubit>().promoCodeMessage != ""
                  ? context.watch<CartCubit>().promoCodeMessage
                  : "*Pay Day Shop Discount ${context.watch<CartCubit>().cartModel!.cart!.discount} SAR"
              : context.watch<CartCubit>().promoCodeMessage,
          style: TextStyle(
              color: context.watch<CartCubit>().promoCodeMessage ==
                      "*Invalid discount code"
                  ? const Color(0xffE30815)
                  : const Color(0xff5A6367),
              fontWeight: FontWeight.w600,
              fontSize: 12),
        )
      ],
    );
  }
}
