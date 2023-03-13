import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';

import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/profile/controller/profile_cubit.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class EditButtonSheet extends StatelessWidget {
  const EditButtonSheet({
    super.key,
    required this.profileCubit,
    required this.profileState,
  });

  final ProfileCubit profileCubit;
  final ProfileState profileState;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        child: LoadingButton(
          key: editProfileButtonKey,
          isLoading: false,
          topPadding: 0,
          onTap: () {
            profileCubit.goToSaveMode();
            profileCubit.setCurrentIsReadOnlyState();
            CustomNavigator.instance.pushReplacementNamed(RoutesName.profile,argument: GlobalKey<FormState>());
          },
          title: 'Edit Profile',
        ),
      ),
    );
  }
}
