import 'package:flutter/material.dart';

import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/bottom_sheet/base_bottom_sheet.dart';
import 'package:res_pay_merchant/core/widget/button/circle_button_widget.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/controller/celebrity_list_controller/celebrity_cubit_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/view/component/video_list/video_sheet_widget.dart';

import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';

import 'package:res_pay_merchant/core/constant/widget_keys.dart';

class StoryActionBar extends StatelessWidget {
  const StoryActionBar({
    super.key,
    required this.celebrityController,
  });

  final CelebrityCubit celebrityController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsetsDirectional.only(start: 15),
        child: Row(
          children: <Widget>[
            CircleIconButton(
              color: Colors.white.withOpacity(0.21),
              child: RotatedBox(
                quarterTurns: isArabic ? 2 : 0,
                child: MyImage.svgAssets(
                  url: "assets/icons/back.svg",
                  color: Colors.white,
                  width: 15,
                  height: 15,
                ),
              ),
              onPressed: () {
                CustomNavigator.instance.pop();
              },
            ),
            const Expanded(child: SizedBox()),
            CircleIconButton(
              key: bookmarkedStoriesKey,
              color: Colors.white.withOpacity(0.21),
              child: MyImage.svgAssets(
                url: "assets/icons/celebrity/save.svg",
                color: Colors.white,
                width: 15,
                height: 15,
              ),
              onPressed: () {
                celebrityController.pause();
                showCustomBottomSheet(
                  context: context,
                  body: VideoSheet(
                    videos: celebrityController.videoShopList,
                  ),
                  hasButtons: false,
                  title: tr('saved_videos'),
                );
              },
            ),
            CircleIconButton(
              key: likedStoriesKey,
              color: Colors.white.withOpacity(0.21),
              child: MyImage.svgAssets(
                url: "assets/icons/celebrity/like.svg",
                color: Colors.white,
                width: 15,
                height: 15,
              ),
              onPressed: () {
                celebrityController.pause();
                showCustomBottomSheet(
                  context: context,
                  body: VideoSheet(
                    videos: celebrityController.videoShopList,
                  ),
                  hasButtons: false,
                  title: tr('liked_videos'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
