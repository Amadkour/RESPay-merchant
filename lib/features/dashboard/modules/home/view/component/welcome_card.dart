import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';

class HomeWelcomeCard extends StatelessWidget {
  const HomeWelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 30, bottom: 30, right: 20),
      decoration: BoxDecoration(
        color: AppColors.greenColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AutoSizeText(
                  tr('Royalty'),
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontFamily: 'Plain'),
                ),
                const SizedBox(
                  height: 5,
                ),
                AutoSizeText(
                  tr('Shop and collect royalties from the shop'),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontFamily: 'Bold',
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: MyImage.assets(
              fit: BoxFit.scaleDown,
              url: 'assets/images/home/reward.png',
              height: 114,
              width: 114,
            ),
          )
        ],
      ),
    );
  }
}
