import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/referral/controller/referral_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/view/page/schedule_call.dart';


class ContactIcon extends StatelessWidget {
  final String url;
  final String label;
  final double opacity;
  final String? linkKey;
  final String color;
  const ContactIcon({
    super.key,required this.color,required this.url,required this.opacity,required this.label,this.linkKey
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: Key(label),
      onTap: () {
        if(linkKey==null){
          inviteFriendBottomSheet(context);
        }
        else{
          sl<ReferralCubit>().launchCurrentUrl(sl<ReferralCubit>().referral!.links![linkKey]! as String);
        }
      },
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(int.parse(color)).withOpacity(opacity),
            ),
            width: 44,
            height: 44,
            child: Center(child: MyImage.svgAssets(url:url,height: 19,width: 19)),
          ),
          const SizedBox(height: 6,),
          AutoSizeText(tr(label),style: TextStyle(
            fontSize: 12,color: AppColors.blackColor,fontWeight: FontWeight.w500
          ),maxFontSize: 13,maxLines: 1,minFontSize: 8
          )
        ],
      ),
    );
  }
}
