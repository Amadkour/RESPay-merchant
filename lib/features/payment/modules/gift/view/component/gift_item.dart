import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/decoration_values.dart';
import 'package:res_pay_merchant/core/res/utils/date.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/controller/beneficiary_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/gift/provider/model/received_gift_model.dart';

class GiftItem extends StatelessWidget {
  final ReceivedGiftModel giftModel;

  const GiftItem({super.key, required this.giftModel});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BeneficiaryCubit, BeneficiaryState>(
      builder: (BuildContext context, BeneficiaryState state) {
        return Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              height: 65,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: defaultBorderRadius),
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: const Color(0xff4EC89E).withOpacity(0.18),
                    child: MyImage.svgAssets(
                      borderRadius: 100.0,
                      url: "assets/images/gift/gift.svg",
                      width: 15.0,
                      height: 15.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 13,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AutoSizeText(giftModel.gift!,
                          style:  TextStyle(
                              fontSize: 15,
                              color: AppColors.blackColor,
                              fontFamily: "SemiBold",
                              fontWeight: FontWeight.bold)),
                      AutoSizeText(
                        dateFormat(giftModel.createdAt!),
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: AppColors.descriptionColor,
                              fontSize: 8,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        );
      },
    );
  }
}
