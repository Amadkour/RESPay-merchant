import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/date.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';

class RecentActivityRow extends StatelessWidget {
  final String title;
  final DateTime date;
  final String amount;
  final bool isGreen;

  const RecentActivityRow(
      {super.key,
      required this.title,
      required this.date,
      required this.amount,
      required this.isGreen});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.getTransactionColor(title.toLowerCase())
                .withOpacity(0.1)),
        child: Center(
          child: MyImage.svgAssets(
            url: title == "deposit"
                ? 'assets/images/home/deposit.svg'
                : "assets/icons/transaction_types/withdraw.svg",
            width: 20,
            height: 20,
            color: AppColors.getTransactionColor(title.toLowerCase()),
          ),
        ),
      ),
      title: AutoSizeText(
        title,
        style: Theme.of(context)
            .textTheme
            .subtitle1!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      trailing: AutoSizeText(
        amount,
        style: Theme.of(context).textTheme.subtitle1!.copyWith(
            color: isGreen ? AppColors.greenColor : Colors.red,
            fontSize: 14,
            fontWeight: FontWeight.w500),
      ),
      subtitle: AutoSizeText(
        dateFormat(date),
        maxLines: 1,
        style: Theme.of(context).textTheme.subtitle1!.copyWith(
              color: AppColors.descriptionColor,
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
      ),
    );
  }
}
