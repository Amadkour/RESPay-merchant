import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/controller/cards_cubit.dart';

class TransactionHistoryList extends StatelessWidget {
  final CardsCubit cubit;

  const TransactionHistoryList(this.cubit);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: <Widget>[
          ...List<Widget>.generate(3, (int index) {
            return SingleTransactionItem(
              cubit: cubit,
              index: index,
            );
          })
        ],
      ),
    );
  }
}

class SingleTransactionItem extends StatelessWidget {
  final int index;
  const SingleTransactionItem(
      {super.key, required this.cubit, required this.index});

  final CardsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.greenColor.withOpacity(0.1)),
            child: Center(
              child: MyImage.svgAssets(
                url: cubit.transactionModels[index].image,
                width: 16,
                height: 16,
              ),
            ),
          ),
          title: Text(
            cubit.transactionModels[index].title!,
            style: bodyStyle.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Text(
            "${cubit.transactionModels[index].transaction}",
            style: bodyStyle.copyWith(
                color:
                    cubit.transactionModels[index].transaction!.startsWith('-')
                        ? Colors.red
                        : AppColors.greenColor),
          ),
          subtitle: Text(
            cubit.transactionModels[index].date!,
            style: smallStyle.copyWith(
              color: AppColors.descriptionColor,
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        if (index != 2)
          Divider(
            thickness: 1,
            color: AppColors.borderColor,
          )
      ],
    );
  }
}
