import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';

import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';

import 'package:res_pay_merchant/core/services/navigation.dart';

import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';

void showCustomBottomSheet({
  required BuildContext context,
  required Widget body,
  VoidCallback? onPressed,
  VoidCallback? onCanceled,
  required String title,
  String? blackButtonTitle,
  bool isTwoButtons = true,
  bool hasButtons = true,
  Color? color,
  EdgeInsetsGeometry? padding,
  EdgeInsetsGeometry? margin,
  //Auto close sheet when confirm button tapped ?
  bool autoClose = true,
  bool isScrollable = false,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Directionality(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: Container(
          constraints: BoxConstraints(maxHeight: context.height * 0.9),
          // margin: margin ?? const EdgeInsets.only(top: 60),
          padding: padding ??
              const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 25,
              ),
          decoration: BoxDecoration(
            color: color ?? Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: padding == null ? 0 : 25,
              ),
              Center(
                child: MyImage.svgAssets(
                  url: 'assets/images/moreBottomsheet/Rectangle.svg',
                  width: 64,
                  height: 5,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 30,
                    left: padding == null ? 0 : 20,
                    right: padding == null ? 0 : 20),
                child: Text(
                  tr(title),
                  style: paragraphStyle.copyWith(
                      color: AppColors.blackColor, fontSize: 16),
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      body,
                      if (hasButtons) ...<Widget>[
                        LoadingButton(
                          hasBottomSaveArea: false,
                          key: sheetApplyButtonKey,
                          isLoading: false,
                          title: blackButtonTitle ?? tr('apply'),
                          onTap: () {
                            onPressed?.call();
                            if (autoClose) {
                              CustomNavigator.instance.pop();
                            }
                          },
                        ),
                        if (isTwoButtons)
                          Center(
                            child: TextButton(
                              key: sheetCancelButtonKey,
                              onPressed: () {
                                CustomNavigator.instance.pop();
                                onCanceled?.call();
                              },
                              child: Text(
                                tr('cancel'),
                                style: buttonsStyle.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          )
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      );
    },
  );
}
