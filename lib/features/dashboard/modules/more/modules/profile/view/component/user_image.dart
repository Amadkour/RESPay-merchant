import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';

import 'package:res_pay_merchant/features/dashboard/modules/more/modules/profile/controller/profile_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/profile/view/pages/full_screen_image.dart';

class UserImage extends StatelessWidget {
  final String? imageURL;
  final File? image;
  final void Function() onChangeImage;

  const UserImage({
    super.key,
    required this.imageURL,
    required this.image,
    required this.onChangeImage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 150,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            bottom: 10,
            child: InkWell(
              onTap: () {
                CustomNavigator.instance.push(routeWidget: const FullScreenImage());
              },
              child: Hero(
                tag: 'imageHero',
                child: getCorrectImage(),
              ),
            ),
          ),
          context.watch<ProfileCubit>().isSaveBottomSheet
              ? Positioned(
                  top: 30,
                  right: 15,
                  child: InkWell(
                    key: changeProfileImageButtonKey,
                    onTap: onChangeImage,
                    child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.blackColor,
                          borderRadius: const BorderRadius.all(Radius.circular(50)),
                          border: Border.all(color: Colors.white, width: 3),
                          //             shape: BoxShape.circle
                        ),
                        child: MyImage.svgAssets(
                          width: 20,
                          height: 14,
                          url: 'assets/icons/referral/camera.svg',
                          color: Colors.white,
                        )),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget getCorrectImage() {
    if (image != null) {
      return MyImage.file(
        url:image!.path,
        width: 105,
        borderRadius: 1000,
        height: 105,
        fit: BoxFit.cover,
      );
    } else {
      return MyImage.network(
          width: 105,
          height: 105,
          borderRadius: 1000,
          fit: BoxFit.cover,
        url: imageURL
      );
    }
  }
}
