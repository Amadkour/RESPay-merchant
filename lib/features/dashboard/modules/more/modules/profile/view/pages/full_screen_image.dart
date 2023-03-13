import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/profile/controller/profile_cubit.dart';

class FullScreenImage extends StatelessWidget {
  const FullScreenImage(
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        color: context.theme.primaryColor,
        height: context.height,
        width: context.width,
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 5,
            ),
            Container(
              color: AppColors.blackColor,
              padding: const EdgeInsets.only(right: 15, left: 15),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  sl<ProfileCubit>().isSaveBottomSheet
                      ? InkWell(
                          child: const Icon(Icons.change_circle_outlined,
                              size: 30, color: Colors.white),
                          onTap: () {
                            sl<ProfileCubit>().onChangeImage();
                          },
                        )
                      : const SizedBox(),
                  const Spacer(),
                  InkWell(
                      onTap: () => CustomNavigator.instance.pop(),
                      child: const Icon(Icons.cancel,
                          size: 30, color: Colors.white)),
                ],
              ),
            ),
            Expanded(
              child: Hero(
                tag: 'imageHero',
                child: BlocProvider<ProfileCubit>.value(
                    value: sl<ProfileCubit>(),
                    child: BlocBuilder<ProfileCubit, ProfileState>(
                        builder: (BuildContext context, ProfileState state) => PhotoView(minScale: PhotoViewComputedScale.contained * 1,
                            imageProvider: getCorrectWidget())))
              ),
            )
          ],
        ),
      )),
    );
  }

  ImageProvider getCorrectWidget() {
    if (sl<ProfileCubit>().image == null) {
      if (sl<ProfileCubit>().profileModel!.imageUrl != null &&
          sl<ProfileCubit>().profileModel!.imageUrl != "") {
        return NetworkImage(sl<ProfileCubit>().profileModel!.imageUrl!);
      } else {
        return const AssetImage("assets/icons/transfer/res_logo.png");
      }
    } else {
      return FileImage(sl<ProfileCubit>().image!);
    }
  }
}
