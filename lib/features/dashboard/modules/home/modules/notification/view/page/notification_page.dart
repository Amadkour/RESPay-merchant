import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/alternative_widgets/empty_widget.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/dialogs/confitm_cancel_dialog.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/notification/controller/notification_cubit.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      scaffold: BlocProvider<NotificationCubit>.value(
        value: sl<NotificationCubit>()..init(),
        child: BlocBuilder<NotificationCubit, NotificationState>(
          builder: (BuildContext context, NotificationState state) {
            if (state is NotificationLoading) {
              return const NativeLoading();
            }
            final NotificationCubit cubit =
                BlocProvider.of<NotificationCubit>(context);
            return cubit.notificationModels.isEmpty
                ? Column(
                    children: <Widget>[
                      const Spacer(),
                      EmptyWidget(
                        width: context.width,
                        height: context.height * 0.3,
                        message: tr('no_notifications'),
                        subMessage: tr('no-notifications-received'),
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.all(24),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            tr('today'),
                            style: TextStyle(
                                color: AppColors.textColor3,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ...List<Widget>.generate(
                              cubit.notificationModels.length,
                              (int index) => Slidable(
                                key: ValueKey<int>(index),

                                startActionPane: ActionPane(

                                  motion: const ScrollMotion(),
                                  children: <Widget>[
                                    SlidableAction(
                                      onPressed: (BuildContext c) {
                                        ConfirmCancelDialog(
                                            context: context,
                                            title: tr(
                                                'sure_delete_notification'),
                                            onConfirm: () {
                                              cubit.deleteNotification(
                                                  index: index);
                                            });
                                        // cubit.deleteNotification(index: index);
                                      },
                                      backgroundColor: AppColors.blackColor,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',

                                    ),

                                  ],
                                ),
                                endActionPane: ActionPane(

                                  motion: const ScrollMotion(),
                                  children: <Widget>[
                                    SlidableAction(
                                      onPressed: (BuildContext c) {
                                        ConfirmCancelDialog(
                                            context: context,
                                            title: tr(
                                                'sure_delete_notification'),
                                            onConfirm: () {
                                              cubit.deleteNotification(
                                                  index: index);
                                            });
                                        // cubit.deleteNotification(index: index);
                                      },
                                      backgroundColor: AppColors.blackColor,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',

                                    ),

                                  ],
                                ),
                                child: Column(
                                      children: <Widget>[
                                        InkWell(
                                          onTap:
                                          cubit.notificationModels[index]
                                                      .readAt ==
                                                  null
                                              ? () {
                                                  ConfirmCancelDialog(
                                                      context: context,
                                                      title: tr(
                                                          'sure_read_notification'),
                                                      onConfirm: () {
                                                        cubit.readNotification(
                                                            index: index);
                                                      });
                                                }
                                              : null,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 20),
                                            decoration: BoxDecoration(
                                                color: cubit
                                                            .notificationModels[
                                                                index]
                                                            .readAt ==
                                                        null
                                                    ? AppColors.lightGreen
                                                        .withOpacity(0.2)
                                                    : Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Row(
                                              children: <Widget>[
                                                MyImage.network(
                                                  url: cubit
                                                      .notificationModels[index]
                                                      .icon,
                                                  width: 40,
                                                  height: 40,
                                                ),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                Expanded(
                                                  child: AutoSizeText(
                                                      cubit
                                                          .notificationModels[
                                                              index]
                                                          .message!,
                                                      minFontSize: 10,
                                                      maxFontSize: 14,
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .blackColor,
                                                          fontFamily:
                                                              'SansArabic',
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                if (cubit
                                                        .notificationModels[index]
                                                        .readAt ==
                                                    null)
                                                  Align(

                                                    alignment: Alignment.centerRight,
                                                    child: Container(
                                                      width: 10,
                                                      height: 10,
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          color: AppColors
                                                              .lightGreen),
                                                    ),
                                                  )
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    ),
                              ))
                        ],
                      ),
                    ),
                  );
          },
        ),
      ),
      appBarWidget: MainAppBar(
        title: tr('notification'),
      ),
    );
  }
}
