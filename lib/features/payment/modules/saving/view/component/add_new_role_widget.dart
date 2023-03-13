import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/widget/bottom_sheet/saving_bottom_sheets.dart';
import 'package:res_pay_merchant/core/widget/dotted_container.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/controller/saving_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/view/component/in_active_wallet_dialog.dart';

class AddNewRoleWidget extends StatelessWidget {
  const AddNewRoleWidget({super.key, required this.cubit});

  final SavingCubit cubit;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        /// When wallet inactive he must activate it first and continue adding role
        if (!cubit.activationWalletSwitcher) {
          InActiveWalletDialog(
            cubit: cubit,
            context: context,
          );
        } else {
          /// Clear the to,from,save text fields
          /// (in case he click update role and then add role)
          cubit.clearRolesControllers();

          /// Show Adding role bottom sheet
          SavingBottomSheet(
              context: context,
              title: tr('add_new_role_title'),
              subTitle: tr('detail_role'),
              blackButtonText: tr('confirm'),
              isTextFieldSection: false,
              availableBalance: cubit.totalMoney);
        }
      },

      /// ------------------- Dotted Container -------------------- ///
      child: EmptyAddDottedWidget(
        key: addNewRoleButtonKey,
        title: tr('add_new_saving_role'),
      ),
    );
  }
}
