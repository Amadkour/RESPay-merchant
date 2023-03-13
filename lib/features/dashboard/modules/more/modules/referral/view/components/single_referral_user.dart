import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/referral/controller/referral_cubit.dart';

class SingleReferralUser extends StatelessWidget {
  const SingleReferralUser({
    super.key,
    required this.index,
    required this.referralCubit,
  });

  final int index;
  final ReferralCubit referralCubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      height: 50,
      child: Row(
        children: <Widget>[
          Container(
            width: 27,
            height: 27,
            decoration: BoxDecoration(
                color: const Color(0xff158CEA).withOpacity(0.1),
                shape: BoxShape.circle
            ),
            child: Center(
              child: MyImage.svgAssets(
                  url: "assets/images/referral/totalreferral.svg",
                  width: 15,
                  height: 15,
                  color: const Color(0xff158CEA)
              ),
            ),
          ),
          const SizedBox(width: 10,),
          Expanded(child:  AutoSizeText(
            referralCubit.referral!.referrals![index].fullName??'',style: TextStyle(
            color: AppColors.blackColor,fontWeight: FontWeight.w600,fontSize:15,
          ),maxFontSize: 15,maxLines: 1,minFontSize: 14,overflow: TextOverflow.ellipsis,),
          ),
          AutoSizeText("${tr("Earn")} 0",style: TextStyle(
              color: AppColors.blackColor,fontWeight: FontWeight.w400,fontSize:14
          ),),
        ],
      ),
    );
  }
}
