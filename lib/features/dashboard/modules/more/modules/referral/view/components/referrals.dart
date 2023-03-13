import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/alternative_widgets/empty_widget.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/referral/controller/referral_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/referral/view/components/single_referral_user.dart';


class ReferralsTab extends StatelessWidget {
   const ReferralsTab({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: context.width,
      height: context.height,
      padding: const EdgeInsets.all(20),
      color: AppColors.backgroundColor,
      child: BlocBuilder<ReferralCubit,ReferralState>(
        builder: (BuildContext context, ReferralState state) {
          final ReferralCubit referralCubit =sl<ReferralCubit>();
          if(state is ReferralLoading){
            return const NativeLoading();
          }
          else{
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(20),
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: Container(
                                  width: 29,
                                  height: 29,
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
                              ),
                              const SizedBox(width: 5,),
                              Flexible(
                                child: FittedBox(
                                  child: AutoSizeText(
                                      referralCubit.referral!.referrals!.length.toString()
                                      ,style: TextStyle(
                                      fontSize: 24,fontWeight: FontWeight.bold,color: AppColors.blackColor
                                  )),
                                ),
                              ),
                              const SizedBox(width: 5,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Flexible(
                                    child: AutoSizeText(tr("User"),style: TextStyle(
                                      fontSize: 16,fontWeight: FontWeight.bold,color: AppColors.blackColor,
                                    ),),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 10,),
                            ],
                          ),
                        ),
                        Container(
                          color: const Color(0xffEDEDED),
                          width: 1,
                        ),
                        const SizedBox(width: 16,),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: Container(
                                  width: 29,
                                  height: 29,
                                  decoration: BoxDecoration(
                                      color: const Color(0xff158CEA).withOpacity(0.1),
                                      shape: BoxShape.circle
                                  ),
                                  child: Center(
                                    child: MyImage.svgAssets(
                                        url: "assets/images/referral/amountearned.svg",
                                        width: 15,
                                        height: 15,
                                        color: const Color(0xff158CEA)
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5,),
                              Flexible(
                                  child: AutoSizeText(
                                    referralCubit.sunOfEarned.toString(),
                                    style: TextStyle(
                                    fontSize: 30,fontWeight: FontWeight.bold,
                                    color: AppColors.blackColor,
                                  ),maxFontSize: 30,maxLines: 1,)
                              ),
                              const SizedBox(width: 5,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Flexible(
                                    child: AutoSizeText(tr("Raial"),style: TextStyle(
                                      fontSize: 16,fontWeight: FontWeight.bold,color: AppColors.blackColor,
                                    ),),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ]
                  ),
                ),
                const SizedBox(height: 32,),
                Expanded(
                  child: !referralCubit.referral!.referrals!.isNotEmpty? SingleChildScrollView(
                    child: EmptyWidget(
                      height: 170,
                      message: tr("No Users Yet"),
                    ),
                  ):ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                    return  SingleReferralUser(referralCubit: referralCubit,index: index,);
                  }, separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height:12);
                  }, itemCount: referralCubit.referral!.referrals!.length),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
