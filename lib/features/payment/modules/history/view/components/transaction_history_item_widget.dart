import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/features/payment/modules/history/provider/model/transaction_model.dart';

class TransactionHistoryItemWidget extends StatelessWidget {
  const TransactionHistoryItemWidget({
    super.key,
    required this.transaction,
    this.isLast = false,
  });

  final TransactionModel transaction;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: transaction.icon == null
              ? Builder(builder: (BuildContext context) {
                  final Color color = AppColors.getTransactionColor(
                      transaction.slug.toLowerCase());
                  return Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color.withOpacity(0.2),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: MyImage.svgAssets(
                      url:
                          "assets/icons/transaction_types/${transaction.slug.toLowerCase()}.svg",
                      color: color,
                      width: 20,
                      height: 20,
                    ),
                  );
                })
              : MyImage.network(
                  url: transaction.icon ?? "",
                  height: 38,
                  width: 38,
                ),
          title: Text(transaction.operationName,
              style: TextStyle(
                  fontFamily: 'Bold',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: AppColors.blackColor)),
          subtitle: Text(
              DateFormat("dd MMMM , hh:mm a").format(transaction.date),
              style: TextStyle(
                  fontFamily: 'Plain',
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: AppColors.otpBorderColor)),
          trailing: Text(
              '${!<String>[
                "deposit"
              ].contains(transaction.slug.toLowerCase()) ? '-' : '+'} ${transaction.amount} ${tr('sar')}',
              style: TextStyle(
                fontFamily: 'semiBold',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: !<String>["deposit"]
                        .contains(transaction.slug.toLowerCase())
                    ? Colors.red
                    : AppColors.greenColor,
              )),
        ),
        if (!isLast)
          const Divider(
            color: Color(0xffEDEDED),
          ),
      ],
    );
  }
}
