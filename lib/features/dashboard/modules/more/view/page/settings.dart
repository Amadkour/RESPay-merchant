import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/controller/more%20cubit/more_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/view/component/items_list.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBarWidget: MainAppBar(backgroundColor: AppColors.backgroundColor, title: "Settings"),
      scaffold: Container(
        color: AppColors.backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: ListOfItems(
          items: sl<MoreCubit>().settingsItems!,
        ),
      ),
    );
  }
}
