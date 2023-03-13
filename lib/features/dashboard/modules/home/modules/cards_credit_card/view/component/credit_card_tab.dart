import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/provider/model/credit_card_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/view/component/cards_list_widget.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards_credit_card/controller/cards_credit_card_cubit.dart';

class CreditCardTab extends StatelessWidget {
  const CreditCardTab({super.key, required this.creditCardModels});

  final List<CreditCardModel> creditCardModels;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardsCreditCardCubit, CardsCreditCardState>(
      builder: (BuildContext context, CardsCreditCardState state) {
        final CardsCreditCardCubit cubit = BlocProvider.of(context);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const _Titles(title: 'Cashback Cards'),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.lightGreen,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: AutoSizeText('New',
                          style: TextStyle(
                              color: AppColors.greenColor,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                SizedBox(
                  height: context.height * 0.02,
                ),
                CardsListWidget(
                  type: cubit.creditCards[cubit.cardsIndex].type!,
                  creditCardModels: creditCardModels,
                  onPageChanged: cubit.onPageChanged,
                  currentIndex: cubit.cardsIndex,
                  cardsVisible: cubit.creditCardsVisible,
                  onChangeVisible: cubit.onChangeVisibility,
                ),
                SizedBox(
                  height: context.height * 0.03,
                ),
                const _Titles(title: 'Cashback Feature'),
                SizedBox(
                  height: context.height * 0.015,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: <Widget>[
                      const _RowListWidget(
                        title:
                            'Sed ut perspiciatis unde omnis iste natus error si',
                      ),
                      const _RowListWidget(
                        title: 'Omnis iste natus error',
                      ),
                      const _RowListWidget(
                        title: 'Dolorem ipsum quia dolor sit amet',
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                        child: Row(
                          children: <Widget>[
                            AutoSizeText(
                              'See More',
                              style: TextStyle(
                                  color: AppColors.darkBlueColor,
                                  fontSize: context.width * 0.03),
                            ),
                            RotatedBox(
                                quarterTurns: 2,
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: AppColors.blueColor,
                                  size: context.width * 0.03,
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: context.height * 0.04,
                ),
                LoadingButton(
                  isLoading: false,
                  title: 'Apply',
                  onTap: () {
                    CustomNavigator.instance.pop();
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class _RowListWidget extends StatelessWidget {
  const _RowListWidget({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: AppColors.lightGreen, shape: BoxShape.circle),
            child: MyImage.svgAssets(
              url: 'assets/images/home/cards/exclamation-mark.svg',
              width: context.width * 0.04,
              height: context.width * 0.04,
            ),
          ),
          SizedBox(
            width: context.width * 0.02,
          ),
          SizedBox(
            width: context.width * 0.7,
            child: AutoSizeText(
              title,
              maxLines: 2,
              style: TextStyle(fontSize: context.width * 0.033),
            ),
          ),
        ],
      ),
    );
  }
}

class _Titles extends StatelessWidget {
  const _Titles({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AutoSizeText(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: context.width * 0.04),
        ),
        AutoSizeText(
          'New Cashback Experience',
          style: TextStyle(
              color: AppColors.textColor3, fontSize: context.width * 0.03),
        ),
      ],
    );
  }
}
