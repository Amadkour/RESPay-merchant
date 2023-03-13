import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/features/authentication/provider/model/terms_privacy_about_model.dart';

class TermsPrivacyWidget extends StatelessWidget {
  const TermsPrivacyWidget({
    super.key,
    required this.termsPrivacyModel,
  });

  final TermPrivacyAboutModel termsPrivacyModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              AutoSizeText(
                termsPrivacyModel.title!,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.blackColor),
              ),
              RotatedBox(
                quarterTurns: termsPrivacyModel.isExpanded! ? 1 : (isArabic ? 0 : 2),
                child: Text(
                  String.fromCharCode(Icons.arrow_back_ios.codePoint),
                  style: TextStyle(
                    inherit: false,
                    color: AppColors.blackColor,
                    fontSize: context.width * 0.04,
                    fontWeight: FontWeight.w700,
                    fontFamily: Icons.close.fontFamily,
                    package: Icons.close.fontPackage,
                  ),
                ),
              ),
            ],
          ),
          if (termsPrivacyModel.isExpanded!)
            Column(
              children: <Widget>[
                SizedBox(
                  height: context.height * 0.015,
                ),
                Divider(color: AppColors.borderColor, thickness: 1.5),
                SizedBox(
                  height: context.height * 0.015,
                ),
              ],
            ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: termsPrivacyModel.isExpanded! ? null : 0,
            child: AutoSizeText(
              termsPrivacyModel.description!,
              style: const TextStyle(color: Color(0xff6D7682), fontSize: 12.8),
            ),
          )
        ],
      ),
    );
  }
}
