import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/shared_orefrences_keys.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/decoration_values.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/local_storage_service.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/bottom_sheet/address_bottom_sheet.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/language/view/component/language_bottom_sheet.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/promotions/controller/promotions_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/support/controller/support_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/providers/models/item_model.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class MoreItem extends StatelessWidget {
  final ItemModel item;
  final FontWeight fontWeight;
  final bool switchValue;
  final ValueChanged<bool>? onSwitchChanged;
  final bool loading;

  const MoreItem({
    super.key,
    required this.item,
    required this.fontWeight,
    this.switchValue = false,
    this.onSwitchChanged,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: getMoreItemKey(item.text!),
      onTap: () async {
        if (item.navigateTo != null) {
          /// setup pin code case
          if (item.navigateTo == RoutesName.setupPinCode) {
            if (await sl<LocalStorageService>().containSecureKey(userPinCode)) {
              CustomNavigator.instance.pushNamed(
                RoutesName.pinCode,
                arguments: <String, dynamic>{
                  "setup": false,
                  "onSuccess": () async {
                    CustomNavigator.instance.pushReplacementNamed(RoutesName.setupPinCode);
                  }
                },
              );
            } else {
              CustomNavigator.instance.pushNamed(item.navigateTo!);
            }
          } else if (item.navigateTo == RoutesName.support) {
            sl<SupportCubit>().reset();
            CustomNavigator.instance.pushNamed(item.navigateTo!,arguments: GlobalKey<FormState>());
          }

          /// other that
          else {
            CustomNavigator.instance.pushNamed(item.navigateTo!);
          }
        }

        /// Bottom sheet case
        else if (item.hasBottomSheet != null) {
          if (item.bottomSheetTitle == 'language') {
            showLanguageBottomSheet(context);
          } else {
            showAddressBottomSheet(
              context: context,
              buttonTitle: tr('use_now'),
            );
          }
        }
      },
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10),
            height: 60,
            decoration: BoxDecoration(color: Colors.white, borderRadius: defaultBorderRadius),
            width: double.infinity,
            child: Row(
              children: <Widget>[
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(color: AppColors.blackColor.withOpacity(0.18), shape: BoxShape.circle),
                  child: Center(
                    child: MyImage.svgAssets(
                      borderRadius: 100.0,
                      url: item.imageUrl,
                      width: 13.0,
                      height: 13.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                AutoSizeText(tr(item.text!),
                    style: TextStyle(fontSize: 14, color: AppColors.blackColor, fontWeight: fontWeight)),
                const Spacer(),
                item.haveRightNumber != null?BlocProvider<PromotionsCubit>.value(
                  value: sl<PromotionsCubit>()..getPromotions(),
                  child: BlocBuilder<PromotionsCubit, PromotionsState>(
                    builder: (BuildContext context, PromotionsState state) {
                        if (state is PromotionsLoading) {
                            return const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            );
                      }
                      if (state is PromotionsError) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          MyToast("Error Happen");
                        });
                        sl<PromotionsCubit>().resetState();
                      }
                      return Container(
                        height: 27,
                        width: 27,
                        decoration: BoxDecoration(
                          color: AppColors.blackColor.withOpacity(0.18),
                          borderRadius: const BorderRadius.all(Radius.circular(100)),
                        ),
                        child: Center(
                            child: BlocProvider<PromotionsCubit>.value(
                              value: sl<PromotionsCubit>(),
                              child: BlocBuilder<PromotionsCubit, PromotionsState>(
                                builder: (BuildContext context, PromotionsState state) => Text(
                                  context.watch<PromotionsCubit>().promotionsModel!.promotions!.length.toString(),
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold, color: AppColors.blackColor, fontSize: 12),
                                ),
                              ),
                            )),
                      );
                    },
                  ),
                ): const SizedBox(),
                (item.haveSwitch != null)
                    ? loading
                        ? const NativeLoading()
                        : Switch(
                            trackColor: MaterialStateProperty.all(const Color(0xff00FF12).withOpacity(0.2)),
                            activeColor: const Color(0xff4EC89E),
                            value: switchValue,
                            onChanged: (bool value) {
                              log("${onSwitchChanged == null}");
                              onSwitchChanged?.call(value);
                            })
                    : const SizedBox(),
              ],
            ),
          ),
          const SizedBox(height: 12)
        ],
      ),
    );
  }
}
