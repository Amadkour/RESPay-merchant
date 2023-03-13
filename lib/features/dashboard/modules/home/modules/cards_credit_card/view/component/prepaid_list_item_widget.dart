import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/bottom_sheet/base_bottom_sheet.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class PrepaidListItemWidget extends StatelessWidget {
  const PrepaidListItemWidget();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showCustomBottomSheet(
            context: context,
            title: 'Digital Cards Cashback',
            body: AutoSizeText(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.   Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in',
              style: TextStyle(color: AppColors.textColor3),
            ),
            isTwoButtons: false,
            blackButtonTitle: 'Apply for Cards',
            onPressed: () {
              CustomNavigator.instance
                  .pushNamed(RoutesName.cashBackDigitalCardsPage);
            });
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        child: Row(
          children: <Widget>[
            MyImage.svgAssets(
              url: 'assets/images/home/cards/prepaid_list_image.svg',
              width: context.width * 0.1,
              height: context.width * 0.1,
            ),
            SizedBox(
              width: context.width * 0.04,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const AutoSizeText(
                  'Digital Cards Cashback',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                AutoSizeText(
                  'Get your cards immediately afte...',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: AppColors.textColor3),
                )
              ],
            ),
            const Spacer(),
            RotatedBox(
                quarterTurns: 2,
                child: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.blackColor,
                  size: 20,
                )),
          ],
        ),
      ),
    );
  }
}
// showSheetPrepaid(BuildContext){
//   showModalBottomSheet(context: context, builder: builder)
// }
