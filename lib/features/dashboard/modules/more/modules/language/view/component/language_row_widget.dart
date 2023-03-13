import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';

class LanguageRowWidget extends StatelessWidget {
  const LanguageRowWidget(
      {super.key,
      this.radioKey,
      required this.imageUrl,
      required this.title,
      required this.value,
      required this.groupValue,
      required this.toggleLanguage});

  final Key? radioKey;
  final String? imageUrl;
  final String? title;
  final String? value;
  final String? groupValue;
  final void Function(String? value)? toggleLanguage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        toggleLanguage!(value);

      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderColor),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: <Widget>[
            Container(
              width: 30,
              height: 40,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: imageUrl!.startsWith('http')
                  ? MyImage.network(
                      url: imageUrl,
                      width: 30,
                      height: 30,
                    )
                  : MyImage.assets(
                      url: imageUrl!,
                      width: 30,
                      height: 30,
                    ),
            ),
            const SizedBox(
              width: 20,
            ),
            AutoSizeText(
              title!,
              style: context.theme.textTheme.subtitle1!.copyWith(
                  fontSize: 14,
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            Radio<String>(
              key: radioKey,
              value: value!,
              groupValue: groupValue,
              onChanged: (String? value) {
                toggleLanguage!(value);
              },
              fillColor: MaterialStateProperty.all(
                context.theme.primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
