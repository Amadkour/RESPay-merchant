import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/bottom_sheet/base_bottom_sheet.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';

class CashBackDigitalCardsPage extends StatelessWidget {
  const CashBackDigitalCardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      scaffold: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const _RowCheckWidget(
                      title: 'Personal Information',
                    ),
                    SizedBox(
                      height: context.height * 0.02,
                    ),
                    const _TitleRowWidget(
                      title: 'Embosing Name',
                      name: 'Malik Maulana',
                    ),
                    SizedBox(
                      height: context.height * 0.03,
                    ),
                    const _RowCheckWidget(
                      title: 'Financial Information',
                    ),
                    SizedBox(
                      height: context.height * 0.02,
                    ),
                    const _TitleRowWidget(
                      title: 'Account Number',
                      name: '0000 - 0000 - 0000 - 0000',
                      isEditIconExists: false,
                    ),
                    SizedBox(
                      height: context.height * 0.02,
                    ),
                    const _TitleRowWidget(
                      title: 'Balance',
                      name: '300.00 SAR',
                    ),
                    SizedBox(
                      height: context.height * 0.02,
                    ),
                    InkWell(
                        child: ColoredBox(
                      color: AppColors.lightGreen2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          MyImage.svgAssets(
                            url: 'assets/images/home/cards/megaphone.svg',
                            width: context.width * 0.05,
                            height: context.width * 0.05,
                          ),
                          SizedBox(
                            width: context.width * 0.02,
                          ),
                          AutoSizeText(
                            'You will get 1.000 points',
                            style: TextStyle(
                                color: AppColors.greenColor,
                                fontSize: context.width * 0.04),
                          )
                        ],
                      ),
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: context.height * 0.08,
              ),
              //by click confirm you agreed to the terms and conditions
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: 'by click confirm you agreed to the ',
                        style: TextStyle(color: AppColors.textColor3)),
                    TextSpan(
                        text: 'terms and conditions',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            showCustomBottomSheet(
                                context: context,
                                title: 'Terms of Conditions',
                                body: AutoSizeText(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.   Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in',
                                  style: TextStyle(color: AppColors.textColor3),
                                ),
                                isTwoButtons: false,
                                blackButtonTitle: 'Apply for Cards',
                                hasButtons: false,
                                onPressed: () {});
                          },
                        style: TextStyle(color: AppColors.blueColor2)),
                  ],
                ),
              ),

              SizedBox(
                height: context.height * 0.02,
              ),
              LoadingButton(
                isLoading: false,
                title: tr('confirm'),
              ),
              LoadingButton(
                isLoading: false,
                title: tr('cancel'),
                onTap: () {
                  CustomNavigator.instance.pop();
                },
                backgroundColor: Colors.transparent,
                fontColor: AppColors.blackColor,
              ),
            ],
          ),
        ),
      ),
      appBarWidget: const MainAppBar(title: 'Cashback Digital Cards'),
    );
  }
}

class _RowCheckWidget extends StatelessWidget {
  const _RowCheckWidget({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            AutoSizeText(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: context.width * 0.042),
            ),
            Icon(
              Icons.check_circle,
              color: AppColors.blueTextColor,
            )
          ],
        ),
        SizedBox(
          height: context.height * 0.015,
        ),
        Divider(
          color: AppColors.greyColor,
          thickness: 2,
        ),
      ],
    );
  }
}

class _TitleRowWidget extends StatelessWidget {
  const _TitleRowWidget(
      {required this.title, required this.name, this.isEditIconExists = true});

  final String title;
  final String name;
  final bool isEditIconExists;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AutoSizeText(
          title,
          style: TextStyle(
              color: AppColors.textColor3,
              fontSize: context.width * 0.035,
              fontWeight: FontWeight.w600),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            AutoSizeText(
              name,
              style: TextStyle(
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: context.width * 0.035),
            ),
            if (isEditIconExists)
              Row(
                children: <Widget>[
                  AutoSizeText(
                    'Edit',
                    style: TextStyle(
                        color: AppColors.blueColor2,
                        fontSize: context.width * 0.035),
                  ),
                  RotatedBox(
                    quarterTurns: 2,
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.blueColor2,
                      size: context.width * 0.035,
                    ),
                  )
                ],
              )
          ],
        )
      ],
    );
  }
}
