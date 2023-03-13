import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/decoration_values.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/controller/beneficiary_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/beneficary_model.dart';

class BeneficiaryItem extends StatelessWidget {
  final Beneficiary beneficiary;
  final bool? isFavoriteIconExists;
  final double imageRadius;
  final bool boolShowType;
  final double? height;
  final double verticalPadding;
  const BeneficiaryItem(
      {super.key,
      this.verticalPadding = 13,
      this.height,
      required this.beneficiary,
      this.isFavoriteIconExists = true,
      this.boolShowType = false,
      required this.imageRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: verticalPadding),
      height: height,
      decoration:
          BoxDecoration(color: Colors.white, borderRadius: defaultBorderRadius),
      width: double.infinity,
      child: Row(
        children: <Widget>[
          ClipRect(
            child: MyImage.network(
              width: 43,
              height: 43,
              borderRadius: 100,
              defaultUrl:
                  "assets/images/transfer/types/${beneficiary.methodType!.toLowerCase().replaceAll(" ", "_")}.png",
              url: beneficiary.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AutoSizeText(
                  "${beneficiary.firstName!} ${beneficiary.lastName!}",
                  style: TextStyle(
                      fontSize: 14,
                      color: AppColors.blackColor,
                      fontFamily: "SemiBold",
                      fontWeight: FontWeight.w700),
                  maxFontSize: 14,
                  maxLines: 1,
                  minFontSize: 11,
                ),
                AutoSizeText(
                    beneficiary.accountNumber ?? beneficiary.phoneNumber ?? "",
                    style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xff2E3B4C),
                        fontWeight: FontWeight.w600),
                    maxFontSize: 12,
                    maxLines: 1,
                    minFontSize: 11),
                boolShowType
                    ? AutoSizeText(
                        "${beneficiary.type == "external" ? tr("International Transfer") : tr("Local Transfer")} • ${beneficiary.methodType}",
                        style: TextStyle(
                            fontSize: 12,
                            color: const Color(0xff5A6367).withOpacity(0.7),
                            fontWeight: FontWeight.w500),
                        maxFontSize: 12,
                        maxLines: 1,
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
          if (isFavoriteIconExists!)
            BlocProvider<BeneficiaryCubit>.value(
              value: sl<BeneficiaryCubit>(),
              child: BlocBuilder<BeneficiaryCubit, BeneficiaryState>(
                buildWhen:
                    (BeneficiaryState previous, BeneficiaryState current) =>
                        sl<BeneficiaryCubit>().currentInFavourite ==
                        beneficiary.uuid!,
                builder: (BuildContext context, BeneficiaryState state) {
                  return InkWell(
                      onTap: () {
                        sl<BeneficiaryCubit>()
                            .setCurrentInFavourite(beneficiary.uuid!);
                        sl<BeneficiaryCubit>().favouriteToggle(
                            beneficiaryUUID: beneficiary.uuid!);
                      },
                      child: MyImage.svgAssets(
                        url: sl<BeneficiaryCubit>().isInFav(beneficiary.uuid!)
                            ? "assets/icons/transfer/fillstar.svg"
                            : "assets/icons/transfer/star.svg",
                        height: 16,
                      ));
                },
              ),
            )
        ],
      ),
    );
  }
}
