import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/parent/parent.dart';

class SearchBar extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  final VoidCallback? onClear;
  final TextEditingController? controller;
  final bool showClear;
  final double verticalPadding;
  final Color? backGroundColor;

  const SearchBar(
      {super.key,
      this.verticalPadding = 10,
      this.backGroundColor,
      this.showClear = false,
      required this.hintText,
      required this.onChanged,
      this.onClear,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return ParentTextField(
      controller: controller,
      onChanged: onChanged,
      verticalPadding: verticalPadding,
      fillColor: backGroundColor ?? AppColors.lightWhite,
      suffix: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          showClear
              ? MyImage.svgAssets(
                  width: 17,
                  height: 17,
                  url: "assets/icons/transfer/searchicon.svg",
                )
              : InkWell(
                  key: searchClearTextFieldButtonKey,
                  onTap: () {
                    onClear?.call();
                  },
                  child: const Icon(
                    Icons.close_sharp,
                    color: Colors.grey,
                    size: 20,
                  )),
          const SizedBox(
            width: 11,
          )
        ],
      ),
      hintStyle: TextStyle(
          fontSize: 13,
          color: AppColors.grayTextColor,
          fontWeight: FontWeight.w300),
      hint: tr(hintText),
      borderRadius: 7,
    );
  }
}
