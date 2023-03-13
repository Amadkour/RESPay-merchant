import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/widget/dialogs/confitm_cancel_dialog.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/controller/cards_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/view/component/switcher_row_widget.dart';

class SettingsList extends StatelessWidget {
  final CardsCubit cubit;

  const SettingsList({required this.cubit});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: <Widget>[
          SwitcherRowWidget(
            switchValue: cubit.lockCard,
            title: tr('lock_card'),
            imageUrl: 'assets/images/home/cards/credit-card.svg',
            onToggleSwitch: cubit.toggleLockCard,
          ),
          SwitcherRowWidget(
            switchValue: cubit.enableNFC,
            title: tr('enable_nfc'),
            imageUrl: 'assets/images/home/cards/wifi-alt.svg',
            onToggleSwitch: cubit.toggleNFC,
          ),
          SwitcherRowWidget(
            switchValue: cubit.enableOnlinePayments,
            title: tr('enable_online'),
            imageUrl: 'assets/images/home/cards/shopping-bag.svg',
            onToggleSwitch: cubit.toggleOnlinePayments,
          ),
          SwitcherRowWidget(
            switchValue: cubit.enableCardPin,
            title: tr('card_pin'),
            imageUrl: 'assets/images/home/cards/password.svg',
            onToggleSwitch: () {
              ConfirmCancelDialog(
                  context: context,
                  title:
                      'Are you sure you want to ${cubit.enableCardPin ? 'deactivate' : 'activate'} the pin on this card?',
                  onConfirm: () {
                    cubit.toggleCardPin();
                  });
            },
          ),
          SwitcherRowWidget(
              title: tr('add_to_apple_wallet'),
              imageUrl: 'assets/images/home/cards/Apple_logo_black 1.svg',
              trailingWidget: RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: '+',
                      style: TextStyle(
                          fontSize: context.width * 0.04,
                          color: AppColors.blueColor2)),
                  TextSpan(
                      text: '  ${tr('connect')}',
                      style: TextStyle(
                          fontSize: context.width * 0.04,
                          color: AppColors.blueColor2))
                ]),
              )),
        ],
      ),
    );
  }
}
