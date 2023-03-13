import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/controller/hom_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/notification/controller/notification_cubit.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class HomeAppBarWidget extends StatelessWidget with PreferredSizeWidget {
  static const Size size = Size.fromHeight(110);

  const HomeAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomCubit, HomeState>(
      builder: (BuildContext context, HomeState state) {
        final HomCubit controller = context.read<HomCubit>();
        return Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
            child: SafeArea(
              bottom: false,
              child: ListTile(
                  leading: SizedBox(
                    height: 40,
                    width: 40,
                    child: MyImage.network(
                      url: controller.imageUrl,
                      borderRadius: 50,
                    ),
                  ),
                  title: Text(
                    tr('Hi,'),
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textColor3,
                        fontFamily: 'Plain'),
                  ),
                  subtitle: AutoSizeText(
                    tr(
                      controller.userName == null ||
                          controller.userName!.isEmpty
                          ? 'dear_customer'
                          : controller.userName ?? 'dear_customer',
                    ),
                    minFontSize: 8,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackColor,
                        fontFamily: 'Bold'),
                  ),
                  trailing: InkWell(
                    onTap: () {
                      CustomNavigator.instance
                          .pushNamed(RoutesName.notification);
                    },
                    child: BlocProvider<NotificationCubit>.value(
                      value: sl<NotificationCubit>(),
                      child: BlocBuilder<NotificationCubit, NotificationState>(
                        builder: (BuildContext context, NotificationState state) {
                          return MyImage.svgAssets(
                            url: context
                                .watch<NotificationCubit>()
                                .readNotificationList
                                .isNotEmpty
                                ? 'assets/images/home/bell_active.svg'
                                : 'assets/images/home/bell.svg',
                            height: 24,
                            width: 21,
                          );
                        },
                      ),
                    ),
                  )),
            ));
      },
    );
  }

  @override
  Size get preferredSize => size;
}
