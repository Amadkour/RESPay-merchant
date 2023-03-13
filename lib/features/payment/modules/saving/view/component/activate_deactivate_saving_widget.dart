import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/widget/custom_switch.dart';
import 'package:res_pay_merchant/core/widget/dialogs/confitm_cancel_dialog.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/controller/saving_cubit.dart';

class ActivateDeactivateSavingWidget extends StatelessWidget {
  const ActivateDeactivateSavingWidget(
      {super.key, required this.cubit});

  final SavingCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: AutoSizeText(
              tr('activate_saving'),
              maxLines: 1,
              minFontSize: 8,
              maxFontSize: 20,
              style: TextStyle(
                  fontSize: context.width * 0.035, fontWeight: FontWeight.w600),
            ),
          ),

          /// ------------------- Switcher ---------------- ///
          CustomSwitch(
            key: activationToggleKey,
            value: cubit.activationWalletSwitcher,
            onChanged: (bool value) {
              ConfirmCancelDialog(
                context: context,
                title: value ? tr('turn_on_saving') : tr('turn_off_saving'),
                onConfirm: () async {
                  final String message =
                      await cubit.onChangeSwitcherValue(newValue: value);
                  if (message.isNotEmpty) {
                    MyToast(message);
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
