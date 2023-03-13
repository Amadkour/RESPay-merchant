import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/bottom_sheet/saving_bottom_sheets.dart';
import 'package:res_pay_merchant/core/widget/custom_switch.dart';
import 'package:res_pay_merchant/core/widget/dialogs/confitm_cancel_dialog.dart';
import 'package:res_pay_merchant/core/widget/alternative_widgets/empty_widget.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/controller/saving_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/view/component/in_active_wallet_dialog.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/view/component/percentage_indicator.dart';

class RolesList extends StatelessWidget {
  const RolesList({super.key, required this.cubit});

  final SavingCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        /// ----------------------- Not Empty Roles -------------------- ///
        if (cubit.roles.isNotEmpty)
          ...List<Widget>.generate(cubit.roles.length, (int index) {
            return Padding(
              padding: const EdgeInsets.only(right: 15, left: 15, bottom: 10),
              child: Column(
                children: <Widget>[
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),

                      /// ----------------------- Role Percentage Indicator -------------------- ///

                      leading: PercentageIndicator(
                        percentage: (cubit.roles[index].value! * 100) /
                            cubit.roles[index].to!,
                      ),

                      /// ----------------------- Role Title -------------------- ///

                      title: AutoSizeText(
                        tr('role'),
                        style: TextStyle(
                            color: AppColors.textColor3, fontSize: 12),
                      ),

                      /// ----------------------- Role Description -------------------- ///
                      subtitle: AutoSizeText(
                        "${tr('from')} ${cubit.roles[index].form} ${tr('sar')} ${tr('to')} ${cubit.roles[index].to} ${tr('sar')}",
                        style: TextStyle(
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                      ),
                      trailing: Theme(
                        data: Theme.of(context).copyWith(
                          iconTheme: IconThemeData(color: AppColors.blackColor),
                        ),

                        /// ----------------------- Role 3 dots menu -------------------- ///
                        child: PopupMenuButton<String>(
                          key: index == 0 ? popupRoleSavingKey : null,
                          itemBuilder: (BuildContext context) {
                            return <PopupMenuItem<String>>[
                              PopupMenuItem<String>(
                                key: deleteRoleButtonKey,
                                value: 'delete',
                                child: Text(tr(tr('delete'))),
                              ),
                              PopupMenuItem<String>(
                                key: updateRoleButtonKey,
                                value: 'update',
                                child: Text(tr('update')),
                              ),
                              PopupMenuItem<String>(
                                key: toggleRoleButtonKey,
                                value: 'toggle',
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(tr('toggle')),

                                    /// ----------------------- Role Toggle Switcher -------------------- ///
                                    CustomSwitch(
                                      value: cubit.roles[index].isActive!,
                                      onChanged: (bool value) async {
                                        if (!cubit.activationWalletSwitcher) {
                                          InActiveWalletDialog(
                                              context: context, cubit: cubit);
                                        } else {
                                          CustomNavigator.instance.pop();

                                          final String message =
                                              await cubit.toggleRole(
                                                  index: index,
                                                  onSuccess: () {
                                                    MyToast(cubit.roles[index]
                                                            .isActive!
                                                        ? tr('turn_on_role')
                                                        : tr('turn_off_role'));
                                                  });
                                          if (message.isNotEmpty) {
                                            MyToast(message);
                                          }
                                        }
                                      },
                                    )
                                  ],
                                ),
                              )
                            ];
                          },

                          /// ----------------------- Handle 3 dots menu cases -------------------- ///
                          onSelected: (String value) async {
                            if (!cubit.activationWalletSwitcher) {
                              InActiveWalletDialog(
                                  context: context, cubit: cubit);
                            } else {
                              switch (value) {

                                /// ----------------------- Delete -------------------- ///

                                case 'delete':
                                  ConfirmCancelDialog(
                                      context: context,
                                      title: tr('delete_role'),
                                      onConfirm: () async {
                                        final String message =
                                            await cubit.deleteRole(
                                          index: index,
                                        );
                                        if (message.isNotEmpty) {
                                          MyToast(message);
                                        }
                                      });
                                  break;

                                /// ----------------------- Toggle -------------------- ///
                                case 'toggle':
                                  final String message = await cubit.toggleRole(
                                      index: index,
                                      onSuccess: () {
                                        MyToast(cubit.roles[index].isActive!
                                            ? tr('turn_on_role')
                                            : tr('turn_off_role'));
                                      });
                                  if (message.isNotEmpty) {
                                    MyToast(message);
                                  }
                                  break;

                                /// ----------------------- Update -------------------- ///
                                case 'update':
                                  SavingBottomSheet(
                                    context: context,
                                    title: tr('update_role'),
                                    to: cubit.roles[index].to,
                                    from: cubit.roles[index].form,
                                    save: cubit.roles[index].value,
                                    subTitle: tr('detail_role'),
                                    blackButtonText: tr('confirm'),
                                    isTextFieldSection: false,
                                    availableBalance: cubit.totalMoney,
                                    index: index,
                                  );
                              }
                            }
                          },
                          child: const Icon(Icons.more_vert),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),

        /// ----------------------- Empty Roles -------------------- ///

        if (cubit.roles.isEmpty)
          EmptyWidget(
            message: tr('no_roles'),
            subMessage: tr('no-roles-received'),
            height: context.height * 0.15,
          ),
      ],
    );
  }
}
