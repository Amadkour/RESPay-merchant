import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';

class CustomDropdown<T> extends StatelessWidget {
  final List<T> items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String Function(T)? itemToString;
  final String? label;
  final Widget? leading;
  final Color? color;
  final bool hasClearButton;
  final VoidCallback? onClear;
  final Key? clearButtonKey;
  final Color borderColor;
  const CustomDropdown({
    super.key,
    required this.items,
    this.onChanged,
    this.itemToString,
    this.label,
    this.value,
    this.leading,
    this.color,
    this.hasClearButton = false,
    this.onClear,
    this.clearButtonKey,
    this.borderColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (label != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                tr(label!),
                style: descriptionStyle.copyWith(
                  color: Colors.black,
                ),
              ),
            ),
          Container(
            height: 52,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            width: double.infinity,
            decoration: BoxDecoration(
                color: color ?? AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: borderColor,
                )),
            child: DropdownButton<T>(
              items: items.map((T e) {
                return DropdownMenuItem<T>(
                  value: e,
                  child: Text(
                    (e != null) ? itemToString?.call(e) ?? "$e" : "",
                    style: textTheme.subtitle1,
                  ),
                );
              }).toList(),
              onChanged: onChanged,
              isExpanded: true,
              underline: const SizedBox(),
              icon: Row(
                children: <Widget>[
                  MyImage.svgAssets(
                    url: "assets/icons/transfer/dropdownarrow.svg",
                    height: 4.5,
                    width: 8,
                  ),
                  if (hasClearButton)
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 20),
                      child: InkWell(
                        key: clearButtonKey,
                        onTap: () {
                          onClear?.call();
                        },
                        child: const Icon(
                          Icons.close_sharp,
                          color: Colors.grey,
                        ),
                      ),
                    )
                ],
              ),
              value: value,
              menuMaxHeight: 300,
            ),
          )
        ]);
  }
}
