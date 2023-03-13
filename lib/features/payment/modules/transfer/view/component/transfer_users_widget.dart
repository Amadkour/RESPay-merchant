import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/widget/dotted_line_widget.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/provider/model/logged_in_user_model.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/beneficary_model.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/res_app_image.dart';

class TransferUsersWidget extends StatelessWidget {
  const TransferUsersWidget({
    super.key,
    required this.to,
  });

  final Beneficiary to;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                const SizedBox(
                  width: 40,
                  child: ResAppImage(),
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: 40,
                  height: 40,
                  child: MyImage.network(
                    width: 40,
                    height: 40,
                    borderRadius: 35.0,
                    url: to.imageUrl ?? "",
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
            Positioned.fill(
              top: 30,
              bottom: 30,
              child: Align(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        color: AppColors.greenColor,
                        shape: BoxShape.circle,
                      ),
                      // padding: const EdgeInsets.all(2),
                      // child: Center(
                      //   child: Container(
                      //     width: 8,
                      //     height: 8,
                      //     decoration: const BoxDecoration(
                      //       color: Colors.white,
                      //     ),
                      //   ),
                      // ),
                    ),
                    Expanded(
                      child: CustomPaint(
                        painter: DashedLineVerticalPainter(
                          color: AppColors.greenColor,
                          width: 2,
                        ),
                      ),
                    ),
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        color: AppColors.greenColor,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(2),
                      child: const Center(
                          child: RotatedBox(
                        quarterTurns: 3,
                        child: Center(
                          child: Icon(
                            Icons.arrow_back_ios_new_sharp,
                            size: 4,
                            color: Colors.white,
                          ),
                        ),
                      )),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    loggedInUser.name ?? "",
                    style: smallStyle,
                  ),
                  Text(
                    loggedInUser.phone ?? "",
                    style: descriptionStyle.copyWith(
                      fontSize: 12,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    to.fullName,
                    style: smallStyle,
                  ),
                  Text(
                    to.accountNumber?.isNotEmpty == true
                        ? to.accountNumber!
                        : to.phoneNumber ?? "",
                    style: descriptionStyle.copyWith(
                      fontSize: 12,
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
