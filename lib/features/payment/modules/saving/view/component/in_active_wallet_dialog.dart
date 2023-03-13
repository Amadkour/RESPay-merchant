import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/widget/dialogs/confitm_cancel_dialog.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/controller/saving_cubit.dart';

/// This dialog appears when user try to do any operation in the saving page
/// and his wallet is inactive, so it asks him to active the wallet first
class InActiveWalletDialog {
  InActiveWalletDialog(
      {required BuildContext context, required SavingCubit cubit}) {
    ConfirmCancelDialog(
        context: context,
        title: tr('activate_wallet'),
        onConfirm: () async {
          final String message =
              await cubit.onChangeSwitcherValue(newValue: true);
          if (message.isNotEmpty) {
            MyToast(message);
          }
        });
  }
}
