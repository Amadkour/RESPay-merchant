import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/leading_trailing_list_widget.dart';
import 'package:res_pay_merchant/core/widget/row_title_widget.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/controller/card_limit/card_limit_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/controller/cards_cubit.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class DetailsCardWidget extends StatelessWidget {
  final CardsCubit cubit;

  const DetailsCardWidget({required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardLimitCubit, CardLimitState>(
      builder: (BuildContext context, CardLimitState state) {
        return Column(
          children: <Widget>[
            RowTitleWidget(
              blackText: tr('detail_cards'),
              blueText: tr('edit_limit'),
              onTapBlueText: () {
                CustomNavigator.instance.pushNamed(RoutesName.changeLimit);
              },
            ),
            SizedBox(
              height: context.height * 0.02,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              padding: EdgeInsets.symmetric(horizontal: context.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  LeadingTrailingListWidget(
                    leadingText: tr('cashback_balance'),
                    trailingText: '${cubit.limitsModel.cashbackBalance}',
                    trailingColor: AppColors.greenColor,
                    isDivider: true,
                  ),
                  Builder(builder: (BuildContext context) {
                    return LeadingTrailingListWidget(
                      leadingText: tr('limit_per_transaction'),
                      trailingText:
                          '${((sl<CardLimitCubit>().transactionLimit * 10).truncate()).toStringAsFixed(0)}.00 ${tr('sar')}',
                      isDivider: true,
                    );
                  }),
                  LeadingTrailingListWidget(
                    leadingText: tr('cas_withdraw_limit'),
                    trailingText:
                        '${((sl<CardLimitCubit>().withdrawLimit * 10).truncate()).toStringAsFixed(0)}.00 ${tr('sar')}',
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
