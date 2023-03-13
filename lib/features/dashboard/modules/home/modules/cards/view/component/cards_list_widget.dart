import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/controller/hom_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/controller/cards_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/provider/model/credit_card_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/view/component/credit_card_widget.dart';

class CardsListWidget extends StatelessWidget {
  final int currentIndex;
  final int? externalIndex;
  final String type;
  final PageController? pageViewController;
  final void Function(int index) onPageChanged;
  final List<CreditCardModel> creditCardModels;
  final List<bool>? cardsVisible;
  final void Function(int index) onChangeVisible;

  const CardsListWidget(
      {required this.onPageChanged,
      required this.currentIndex,
      this.pageViewController,
      required this.cardsVisible,
      required this.onChangeVisible,
      required this.creditCardModels,
      required this.type,
      this.externalIndex});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomCubit>.value(
      value: sl<HomCubit>(),
      child: BlocBuilder<HomCubit, HomeState>(
        builder: (BuildContext context, HomeState state) {
          return BlocProvider<CardsCubit>.value(
            value: sl<CardsCubit>(),
            child: BlocBuilder<CardsCubit, CardsState>(
              builder: (BuildContext context, CardsState state) {
                return Column(
                  children: <Widget>[
                    /// If pressed on view all cards
                    if (externalIndex == null)
                      SizedBox(
                        height: context.width * 0.5,
                        child: PageView(
                          controller: pageViewController,
                          onPageChanged: onPageChanged,
                          children: <Widget>[
                            ...List<Widget>.generate(
                                creditCardModels.length,
                                (int index) => CreditCardWidget(
                                    index: index,
                                    cardsVisible: cardsVisible,
                                    creditCardModels: creditCardModels,
                                    onChangeVisible: onChangeVisible))
                          ],
                        ),
                      ),

                    /// If pressed on a specefic card
                    if (externalIndex != null)
                      CreditCardWidget(
                          index: externalIndex ?? 0,
                          creditCardModels: creditCardModels,
                          cardsVisible: cardsVisible,
                          onChangeVisible: onChangeVisible),
                    SizedBox(
                      height: context.height * 0.02,
                    ),
                    if (creditCardModels.length > 1 && externalIndex == null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ...List<Widget>.generate(
                            creditCardModels.length,
                            (int index) => Row(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 4,
                                  backgroundColor: currentIndex == index
                                      ? AppColors.blackColor
                                      : const Color(0xffCFCFCF),
                                ),
                                const SizedBox(
                                  width: 4,
                                )
                              ],
                            ),
                          )
                        ],
                      )
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
