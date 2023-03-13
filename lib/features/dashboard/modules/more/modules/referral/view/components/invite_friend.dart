import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/referral/controller/referral_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/referral/view/components/contact_icon.dart';

class InviteFriend extends StatelessWidget {
  const InviteFriend({super.key});
  @override
  Widget build(BuildContext context) {
    final ReferralCubit referralCubit =sl<ReferralCubit>();

    return ColoredBox(
      color: AppColors.backgroundColor,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 32,),
            MyImage.svgAssets(
              height: 180,
              url: "assets/images/referral/invite.svg",
            ),
            const SizedBox(height: 16,),
            AutoSizeText(tr('Invite Friend Use Res Pay'),style: TextStyle(
                fontSize: 17,fontWeight: FontWeight.bold,color: AppColors.blackColor
            ),maxFontSize: 18),
            const SizedBox(height: 4,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45),
              child: AutoSizeText(tr("Maximize your monthly earnings by inviting your friends to the app. We have a lot of advantages in our referral program"),style: const TextStyle(
                  fontSize: 13,color: Color(0xff5A6367)
              ),maxFontSize: 16,textAlign: TextAlign.center),
            ),
            const SizedBox(height: 23,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AutoSizeText(tr("Your Referral Code"),style: TextStyle(
                  fontSize: 13,color: AppColors.blackColor,fontWeight: FontWeight.w500
              ),maxFontSize: 16,textAlign: TextAlign.center),
            ),
            const SizedBox(height: 5,),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                    height: 50,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),

                    child: BlocBuilder<ReferralCubit,ReferralState>(
                      builder: (BuildContext context, ReferralState state) {
                        if(state is ReferralLoading){
                          return const NativeLoading();
                        }
                        else{
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              AutoSizeText(
                                referralCubit.referral!.refCode!,
                                maxFontSize: 12,
                                minFontSize: 9,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 12,color: AppColors.blackColor,fontWeight: FontWeight.bold
                                ),
                              ),
                              InkWell(
                                key: copyReferralLinkKey,
                                onTap:() async{
                                  await referralCubit.copy();
                                },
                                child: MyImage.svgAssets(
                                  height: 16,
                                  width: 16,
                                  url: "assets/icons/referral/copy.svg",
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    )
                )
            ),
            const SizedBox(height: 16,),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        flex: 2,
                        child: Container(height: 1,color: const Color(0xff262626).withOpacity(0.28),)),
                    const SizedBox(width: 6,),
                    AutoSizeText(tr("or invite via"),style: TextStyle(
                        color: AppColors.textColor3,fontSize: 12.8
                    )),
                    const SizedBox(width: 6,),
                    Expanded(
                        flex: 2,
                        child: Container(height: 1,color: const Color(0xff262626).withOpacity(0.28),)),
                  ],
                )
            ),
            const SizedBox(height: 16,),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const <Widget>[
                    ContactIcon(
                      linkKey: "email",
                      url: "assets/images/referral/mail.svg",
                      color: "0xffF79E1B",
                      opacity: 0.1,
                      label: "E-mail",
                    ),
                    ContactIcon(
                      linkKey: "what'sapp",
                      url: "assets/images/referral/whatsapp.svg",
                      color: "0xff25D366",
                      opacity: 0.2,
                      label: "Whatsapp",
                    ),
                    ContactIcon(
                      linkKey: "facebook",
                      url: "assets/images/referral/facebook.svg",
                      color: "0xffE6ECF6",
                      opacity: 1,
                      label: "Facebook",
                    ),
                    ContactIcon(
                      url: "assets/images/referral/other.svg",
                      color: "0xff5A6367",
                      opacity: 0.1,
                      label: "Other",
                    ),
                  ],
                )
            ),
            const SizedBox(height: 40,),
          ],
        ),
      ),
    );

  }

}

class InviteFriendBottomSheetBody extends StatelessWidget {
  const InviteFriendBottomSheetBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReferralCubit>.value(
      value: sl<ReferralCubit>(),
      child: BlocBuilder<ReferralCubit,ReferralState>(
        builder: (BuildContext context, ReferralState state) {
          final ReferralCubit referralCubit =sl<ReferralCubit>();
          return SafeArea(
              child: Container(
                height: kBottomNavigationBarHeight * referralCubit.referral!.links!.length+ context.bottomPadding+20,
                padding: const EdgeInsets.all(20),
                child: MainScaffold(
                  backgroundColor: Colors.white,
                  scaffold: ListView.separated(
                      shrinkWrap: true,
                      itemCount: referralCubit.referral!.links!.length,
                      separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10),
                      itemBuilder: (BuildContext context, int index) => SingleSocialMediaLink(referralCubit: referralCubit,index: index,)
                  ),
                ),
              )
          );
        },
      ),
    );
  }
}

class SingleSocialMediaLink extends StatelessWidget {
  const SingleSocialMediaLink({
    super.key,
    required this.referralCubit,required this.index
  });

  final ReferralCubit referralCubit;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        referralCubit.launchCurrentUrl(referralCubit.referral!.links!.values.elementAt(index) as String);
      },
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.backgroundColor,
            ),
            width: 40,
            height: 40,
            child: Center(child: MyImage.assets(url:"assets/images/referral/defaultimageforsocialmedialinks.png",height: 20,width: 20)),
          ),
          const SizedBox(width: 10,),
          Text(referralCubit.referral!.links!.keys.elementAt(index))
        ],
      ),
    );
  }
}
