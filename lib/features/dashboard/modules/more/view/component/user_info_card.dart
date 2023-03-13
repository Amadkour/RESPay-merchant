import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/decoration_values.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/profile/controller/profile_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/profile/provider/model/profile_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/profile/provider/repository/profile_repository.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class UserInfoCard extends StatelessWidget {
  final ProfileModel profileModel;
  const UserInfoCard({
    super.key,required this.profileModel
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: goToProfileInfoButtonKey,
      onTap: () async{
        sl<ProfileCubit>().init();
        sl<ProfileCubit>().cancel();
        CustomNavigator.instance.pushNamed( RoutesName.profile,arguments: GlobalKey<FormState>());
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 84,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: defaultBorderRadius),
        width: double.infinity,
        child: Row(
          children: <Widget>[
            CircleAvatar(
              child: sl<ProfileRepository>().data!.imageUrl==null?
              const Icon(Icons.person):
              MyImage.network(
                borderRadius: 100.0,
                url:sl<ProfileRepository>().data!.imageUrl,
                width: 55.0,
                height: 55.0,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AutoSizeText(profileModel.fullName!,
                    style: TextStyle(
                        fontSize: 16,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w500),
                    maxFontSize: 16,
                    maxLines: 1,
                    minFontSize: 8),
                AutoSizeText(profileModel.email!,
                    style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textColor3.withOpacity(0.7),
                        fontFamily: "SemiLight",
                        fontWeight: FontWeight.w400)),
              ],
            ),
            const Spacer(),
            isArabic
                ? RotatedBox(
                    quarterTurns: 2,
                    child: MyImage.svgAssets(
                      url: "assets/icons/transfer/rightarrow.svg",
                      height: 25,
                    ),
                  )
                : MyImage.svgAssets(
                    url: "assets/icons/transfer/rightarrow.svg",
                    height: 25,
                  )
          ],
        ),
      ),
    );
  }
}
