import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';

import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/res_app_image.dart';

class ConversionRateWidget extends StatelessWidget {
  const ConversionRateWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: <Widget>[
            //! Currency conversion widget
            ListTile(
              leading: const SizedBox(
                width: 35,
                child: CircleAvatar(
                  radius: 26,
                  backgroundImage: AssetImage(
                    "assets/images/flags/Egypt-Flag-icon.png",
                  ),
                ),
              ),
              contentPadding: EdgeInsets.zero,
              title: AutoSizeText(
                "EGP",
                style: descriptionStyle.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ),
              subtitle: AutoSizeText(
                "1.00 SAR = 6.50 EGP",
                style: descriptionStyle,
              ),
              trailing: AutoSizeText(
                "3520.00 EGP",
                style: descriptionStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Divider(
              color: AppColors.systemBodyColor,
              height: 23,
            ),

            //! res pay conversion widget
            ListTile(
              leading: const SizedBox(
                width: 35,
                child: ResAppImage(),
              ),
              contentPadding: EdgeInsets.zero,
              title: Text(
                "res_pay",
                style: descriptionStyle.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  AutoSizeText(
                    "3520.00 EGP",
                    style: descriptionStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  AutoSizeText(
                    tr("best price"),
                    style: descriptionStyle.copyWith(
                      color: AppColors.greenColor,
                    ),
                  )
                ],
              ),
            ),
            const Divider(
              height: 23,
            ),

            //! other competitors conversion widget
            ListTile(
              leading: SizedBox(
                width: 35,
                child: CircleAvatar(
                  radius: 26,
                  backgroundColor: AppColors.greenColor.withOpacity(0.2),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/icons/transfer/bank.png"),
                  ),
                ),
              ),
              contentPadding: EdgeInsets.zero,
              title: AutoSizeText(
                tr("other_competitors"),
                style: descriptionStyle.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  AutoSizeText(
                    "3220.00 EGP",
                    style: descriptionStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.red,
                      ),
                      AutoSizeText(
                        "-30.00",
                        style: descriptionStyle.copyWith(
                          color: Colors.red,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: AutoSizeText(
                tr("this_amount_estimate"),
                style: const TextStyle(
                    color: Color(0xff9FA5A7),
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ));
  }
}
