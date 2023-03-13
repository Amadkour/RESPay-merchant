import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/controller/celebrity_list_controller/celebrity_cubit_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/controller/celebrity_list_controller/celebrity_cubit_state.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/model/video_shop.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';

class VideoSheet extends StatelessWidget {
  const VideoSheet({super.key, required this.videos});
  final List<Story> videos;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: BlocProvider<CelebrityCubit>.value(
          value: sl<CelebrityCubit>(),
          child: Builder(builder: (BuildContext context) {
            final CelebrityCubit celebrityController =
                context.read<CelebrityCubit>();
            return BlocBuilder<CelebrityCubit, CelebrityState>(
              builder: (BuildContext context, CelebrityState state) => GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: videos
                    .map(
                      (Story story) => InkWell(
                        onTap: () {
                          CustomNavigator.instance.pushNamed(
                            RoutesName.storyPage,
                            arguments: story,
                          );
                        },
                        child: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            if (story.type == "image")
                              MyImage.network(
                                fit: BoxFit.cover,
                                url: story.mediaLink,
                                height: 230,
                                borderRadius: 15,
                              )
                            else
                              FutureBuilder<File?>(
                                future: celebrityController
                                    .createThumbnail(story.mediaLink),
                                builder: (BuildContext context,
                                    AsyncSnapshot<File?> snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.data != null) {
                                    return MyImage.file(
                                      url: snapshot.data!.path,
                                      height: 230,
                                      borderRadius: 15,
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                            Center(
                              child: MyImage.svgAssets(
                                url: "assets/icons/celebrity/play.svg",
                                width: 19,
                                height: 23,
                              ),
                            ),
                            Positioned.directional(
                              bottom: 10,
                              end: 10,
                              textDirection: isArabic
                                  ? TextDirection.rtl
                                  : TextDirection.ltr,
                              child: Container(
                                height: 64,
                                width: 46,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: MyImage.assets(
                                    url: story.userImage,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            );
          }),
        ));
  }
}
