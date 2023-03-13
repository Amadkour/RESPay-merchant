import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/controller/celebrity_list_controller/celebrity_cubit_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/controller/celebrity_list_controller/celebrity_cubit_state.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/model/video_shop.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/view/component/video_list/media_widget.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/view/component/video_list/story_action_bar_widget.dart';

class VideoListPage extends StatefulWidget {
  const VideoListPage({super.key});

  @override
  State<VideoListPage> createState() => _VideoListPageState();
}

class _VideoListPageState extends State<VideoListPage> {
  @override
  void dispose() {
    sl<CelebrityCubit>().closeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      scaffold: BlocProvider<CelebrityCubit>.value(
        value: sl<CelebrityCubit>(),
        child: Builder(builder: (BuildContext context) {
          final CelebrityCubit celebrityController =
              context.read<CelebrityCubit>();
          return Stack(
            children: <Widget>[
              BlocBuilder<CelebrityCubit, CelebrityState>(
                builder: (BuildContext context, CelebrityState state) {
                  return PageView.builder(
                    key: storiesPageViewKey,
                    itemCount: celebrityController.videoShopList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      final Story image =
                          celebrityController.videoShopList.elementAt(index);

                      return MediaWidget(
                        key: ValueKey<int>(index),
                        image: image,
                      );
                    },
                  );
                },
              ),

              //------- action bar------///
              StoryActionBar(
                celebrityController: celebrityController,
              ),
            ],
          );
        }),
      ),
    );
  }
}
