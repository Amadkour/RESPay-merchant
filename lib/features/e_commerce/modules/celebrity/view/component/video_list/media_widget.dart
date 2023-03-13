import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:res_pay_merchant/core/res/utils/extenstions.dart';

import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/controller/celebrity_list_controller/celebrity_cubit_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/controller/celebrity_list_controller/celebrity_cubit_state.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/model/video_shop.dart';
import 'package:video_player/video_player.dart';

import 'package:res_pay_merchant/core/res/theme/colors.dart';

import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';

class MediaWidget extends StatefulWidget {
  const MediaWidget({
    super.key,
    required this.image,
  });

  final Story image;

  @override
  State<MediaWidget> createState() => _MediaWidgetState();
}

class _MediaWidgetState extends State<MediaWidget> {
  @override
  void initState() {
    super.initState();
    final CelebrityCubit controller = context.read<CelebrityCubit>();

    if (widget.image.track != null) {
      controller.initSound(widget.image.track!.link);
    }
    if (widget.image.type == "video") {
      controller.initVideo(widget.image.mediaLink);
    }
  }

  @override
  void deactivate() {
    if (widget.image.track != null) {
      context.read<CelebrityCubit>().closePlayer();
    }

    if (widget.image.type == "video") {
      context.read<CelebrityCubit>().closeVideoPlayer();
    }
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final CelebrityCubit controller = context.read<CelebrityCubit>();

    return Stack(
      children: <Widget>[
        widget.image.type == "image"
            ? MyImage.network(
                url: widget.image.mediaLink,
                width: double.infinity,
                height: double.infinity,
              )
            : BlocBuilder<CelebrityCubit, CelebrityState>(
                buildWhen: (CelebrityState previous, CelebrityState current) {
                  return current is CelebrityVideoLoaded;
                },
                builder: (BuildContext context, CelebrityState state) {
                  final CelebrityCubit celebrityController =
                      context.read<CelebrityCubit>();
                  return celebrityController.controller.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: (context.width / context.height) + 0.05,
                          child: VideoPlayer(controller.controller),
                        )
                      : Container();
                },
              ),
        Positioned(
          bottom: 30,
          right: 20,
          left: 20,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.celebrityProductContainerColor
                            .withOpacity(0.5),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsetsDirectional.only(
                          start: 6, top: 6, bottom: 6, end: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          MyImage.svgAssets(
                            url: "assets/icons/celebrity/see_products.svg",
                            width: 30,
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                                start: 7, end: 12),
                            child: Text(
                              tr('see_products'),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          MyImage.svgAssets(
                            url: "assets/icons/transfer/dropdownarrow.svg",
                            width: 10,
                            height: 5,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 7),
                      child: Text(
                        widget.image.description,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    if (widget.image.track != null)
                      Row(
                        children: <Widget>[
                          MyImage.svgAssets(
                            url: "assets/icons/celebrity/music.svg",
                            width: 13,
                            height: 14,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            widget.image.track?.name ?? "",
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                  ],
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                children: <Widget>[
                  Container(
                    width: 47,
                    height: 47,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                      ),
                    ),
                    child: MyImage.assets(
                      borderRadius: 47,
                      url: widget.image.userImage,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 22),
                    child: IconButton(
                      onPressed: () {},
                      icon: MyImage.svgAssets(
                        url: "assets/icons/celebrity/like.svg",
                        width: 22,
                        height: 22,
                      ),
                    ),
                  ),
                  Text(
                    widget.image.likeCount.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 22),
                    child: IconButton(
                      onPressed: () {},
                      icon: MyImage.svgAssets(
                        url: "assets/icons/celebrity/save.svg",
                        width: 22,
                        height: 22,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 47),
                    child: Text(
                      widget.image.saveCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  if (widget.image.track != null)
                    Container(
                      width: 49,
                      height: 49,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: <Color>[
                            Color.fromRGBO(57, 57, 57, 1),
                            Color.fromRGBO(21, 21, 21, 1),
                            Color.fromRGBO(57, 57, 57, 1),
                            Color.fromRGBO(22, 22, 22, 1),
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: MyImage.assets(
                        url: widget.image.track!.image,
                      ),
                    ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
