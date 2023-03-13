import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/payment/modules/analytics/controller/analytics_cubit.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class CategoryBottomSheetWidget extends StatelessWidget {
  const CategoryBottomSheetWidget(
      {super.key, required this.index, this.isAuthorized = true});
  final int index;
  final bool isAuthorized;
  @override
  Widget build(BuildContext context) {
    final AnalyticsCubit analyticCubit =
        sl<AnalyticsCubit>(instanceName: isAuthorized ? "user" : 'guest');
    return BlocProvider<AnalyticsCubit>.value(
      value: analyticCubit,
      child: Builder(builder: (BuildContext context) {
        return Column(
          children: <Widget>[
            ListTile(
              onTap: () {
                analyticCubit.initCategoryForEdit(index);
                CustomNavigator.instance.pop();
                CustomNavigator.instance.pushNamed(
                  RoutesName.addCategory,
                  arguments: <String, dynamic>{
                    "index": index,
                    "isAuthorized": true
                  },
                );
              },
              contentPadding: EdgeInsets.zero,
              leading: Container(
                width: 40,
                height: 40,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.borderColor,
                  shape: BoxShape.circle,
                ),
                child: MyImage.svgAssets(url: "assets/icons/edit.svg"),
              ),
              title: Text(
                tr("edit_category"),
                style: paragraphStyle.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            BlocListener<AnalyticsCubit, AnalyticsState>(
              listener: (BuildContext context, Object? state) {
                CustomNavigator.instance.pop();
                MyToast(tr("category_deleted"),
                    background: AppColors.greenColor);
              },
              child: ListTile(
                onTap: () {
                  CustomNavigator.instance.pop();
                  analyticCubit.deleteCategory(index);
                },
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  width: 40,
                  height: 40,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.borderColor,
                    shape: BoxShape.circle,
                  ),
                  child: MyImage.svgAssets(url: "assets/icons/trash.svg"),
                ),
                title: Text(
                  tr("delete_category"),
                  style: paragraphStyle.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.black,
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
