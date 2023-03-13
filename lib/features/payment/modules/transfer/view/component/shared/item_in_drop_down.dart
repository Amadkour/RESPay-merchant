import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/decoration_values.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/transfer_details/text_field_label.dart';

class ItemInDropDown extends StatelessWidget {
  const ItemInDropDown(
      {super.key,
      required this.itemText,
      this.itemImageUrl,
      this.defaultSvgImage = "assets/flags/saudi_arabia.svg",
      this.haveImage = false});

  final String itemText;
  final String? itemImageUrl;
  final String? defaultSvgImage;
  final bool haveImage;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: AppColors.lightWhite, borderRadius: defaultBorderRadius),
        alignment: isArabic ? Alignment.centerRight : Alignment.centerLeft,
        padding: const EdgeInsets.all(3),
        child: Row(
          textDirection: !isArabic ? TextDirection.ltr : TextDirection.rtl,
          children: <Widget>[
            if (haveImage)
              Padding(
                padding: EdgeInsets.only(
                    right: !isArabic ? 7 : 0, left: !isArabic ? 0 : 7),
                child: ClipOval(
                  child: itemImageUrl != null
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(1000),
                            child: SvgPicture.network(
                              itemImageUrl!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : MyImage.svgAssets(
                          url: defaultSvgImage,
                          height: 22,
                          width: 20,
                        ),
                ),
              )
            else
              const SizedBox.shrink(),
            Expanded(
                child: AutoSizeText(itemText,
                    overflow: TextOverflow.ellipsis,
                    textDirection:
                        !isArabic ? TextDirection.ltr : TextDirection.rtl,
                    style: getStyle(
                      size: 12,
                      fontFamily: "Plain",
                      fontWeight: FontWeight.w500,
                    ))),
          ],
        ));
  }
}
