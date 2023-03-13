import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/controller/beneficiary_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/summary/summary_title.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/transfer_details/build_title_with_subtitle_info.dart';

class ResAppLocalSummary extends StatelessWidget {
  const ResAppLocalSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: context.height,
        padding: const EdgeInsets.all(18),
        color: AppColors.lightWhite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                width: context.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SummaryTitle(),
                      const SizedBox(
                        height: 7,
                      ),
                      Container(
                        color: AppColors.blackColor.withOpacity(0.2),
                        height: 1,
                      ),
                      TitleWithSubtitleInfo(
                        haveButtonInRow: false,
                        title: "PHONE NUMBER",
                        subtitle: sl<BeneficiaryCubit>().phoneNumber,
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      TitleWithSubtitleInfo(
                        haveButtonInRow: false,
                        title: "FIRST NAME",
                        subtitle: sl<BeneficiaryCubit>().firstName,
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      TitleWithSubtitleInfo(
                        haveButtonInRow: true,
                        title: "FAMILY NAME",
                        subtitle: sl<BeneficiaryCubit>().lastName,
                      ),
                      const SizedBox(
                        height: 24,
                      )
                    ])),
            const SizedBox(
              height: 160,
            )
          ],
        ),
      ),
    );
  }
}
