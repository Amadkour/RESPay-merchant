import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/controller/celebrity_list_controller/celebrity_cubit_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/model/video_shop.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/view/component/video_list/media_widget.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/view/component/video_list/story_action_bar_widget.dart';

class SingleStoryPreviewPage extends StatelessWidget {
  const SingleStoryPreviewPage({super.key, required this.story});
  final Story story;
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      scaffold: BlocProvider<CelebrityCubit>.value(
        value: sl<CelebrityCubit>(),
        child: Builder(builder: (BuildContext context) {
          final CelebrityCubit celebrityController = context.read<CelebrityCubit>();
          return Stack(
            children: <Widget>[
              MediaWidget(image: story),
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
