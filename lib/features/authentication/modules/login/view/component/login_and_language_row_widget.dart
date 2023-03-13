import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';

/// First row in the login page
/// Part of [LoginPage]
class LoginAndLanguageRowWidget extends StatelessWidget {
  final double fullWidth;
  final double fullHeight;
  final void Function(String value) onChangeLanguageIndex;
  final String languageDropDownValue;

  const LoginAndLanguageRowWidget(
      {super.key,
      required this.fullWidth,
      required this.fullHeight,
      required this.onChangeLanguageIndex,
      required this.languageDropDownValue});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          tr('login'),
          style: TextStyle(
              color: AppColors.blackColor,
              fontSize: fullWidth * 0.04,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(
          width: fullWidth * 0.3,
          height: fullHeight * 0.05,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
                isExpanded: true,
                value: languageDropDownValue,
                items: <DropdownMenuItem<String>>[
                  DropdownMenuItem<String>(
                    value: 'en',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        MyImage.assets(
                          url: 'assets/icons/login/english.png',
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          tr('english'),
                          style: TextStyle(fontSize: fullWidth * 0.037),
                        )
                      ],
                    ),
                  ),
                  DropdownMenuItem<String>(
                    value: 'ar',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        MyImage.assets(
                          url: 'assets/icons/login/arabic.png',
                          width: 16,
                          height: 16,
                        ),
                        Text(tr('arabic'),
                            style: TextStyle(fontSize: fullWidth * 0.04))
                      ],
                    ),
                  )
                ],
                onChanged: (String? value){
                  onChangeLanguageIndex(value!);
                }),
          ),
        )
      ],
    );
  }
}
