import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/controller/celebrity_list_controller/celebrity_cubit_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/controller/celebrity_list_controller/celebrity_cubit_state.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/enum/gender.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/view/component/celebrity_list/celebrity_filter_chip_widget.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/view/component/celebrity_list/celebrity_list_widget.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';

import 'package:res_pay_merchant/core/constant/widget_keys.dart';

import 'package:res_pay_merchant/core/res/theme/colors.dart';

class CelebrityListPage extends StatelessWidget {
  const CelebrityListPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CelebrityCubit>.value(
      value: sl<CelebrityCubit>(),
      child: Builder(builder: (BuildContext context) {
        final CelebrityCubit celebrityController =
            context.read<CelebrityCubit>();
        return MainScaffold(
          appBarWidget: MainAppBar(
            title: tr("celebrity"),
            showBackButton: false,
            actions: UnconstrainedBox(
              child: IconButton(
                key: storiesButtonKey,
                onPressed: () {
                  CustomNavigator.instance.pushNamed(RoutesName.videoList);
                },
                icon: MyImage.svgAssets(
                  url: "assets/icons/celebrity/shopping-bag.svg",
                  width: 25,
                  height: 25,
                ),
              ),
            ),
          ),
          scaffold:
              CelebrityListScaffold(celebrityController: celebrityController),
        );
      }),
    );
  }
}

class CelebrityListScaffold extends StatelessWidget {
  const CelebrityListScaffold({
    super.key,
    required this.celebrityController,
  });

  final CelebrityCubit celebrityController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: InkWell(
                key: celebritySearchInkwell,
                onTap: () => CustomNavigator.instance
                    .pushNamed(RoutesName.celebritySearch),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Row(
                    children: <Widget>[
                      MyImage.svgAssets(
                        url: "assets/icons/search.svg",
                        width: 15,
                        height: 15,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        tr("find_celebrity"),
                        style: descriptionStyle.copyWith(
                          color: AppColors.greyColor,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: BlocBuilder<CelebrityCubit, CelebrityState>(
                builder: (BuildContext context, CelebrityState state) {
                  return Row(
                    children: CelebrityGender.values
                        .map(
                          (CelebrityGender e) => CelebrityFilterChip(
                            key: ValueKey<CelebrityGender>(e),
                            value: e,
                            active: celebrityController.genderFilter == e,
                            onPressed: celebrityController.changeGender,
                          ),
                        )
                        .toList(),
                  );
                },
              ),
            ),
            CelebrityListWidget(celebrityController: celebrityController)
          ],
        ),
      ),
    );
  }
}
