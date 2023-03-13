import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/controller/card_limit/card_limit_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/view/component/slider_card_widget.dart';

class CardLimitPage extends StatelessWidget {
  const CardLimitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CardLimitCubit>.value(
      value: sl<CardLimitCubit>()..init(),
      child: BlocBuilder<CardLimitCubit, CardLimitState>(
        builder: (BuildContext context, CardLimitState state) {
          final CardLimitCubit cubit = BlocProvider.of(context);
          return MainScaffold(
            appBarWidget: MainAppBar(title: tr('change_limit')),
            scaffold: Padding(
              padding: const EdgeInsets.only(right: 12, left: 12, top: 32),
              child: SizedBox(
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: context.height * 0.77,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AutoSizeText(
                          tr('limit_per_transaction'),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: context.width * 0.04),
                        ),
                        SizedBox(
                          height: context.height * 0.013,
                        ),
                        SliderCardWidget(
                            sliderValue: cubit.transactionSlider,
                            onChangeSliderValue:
                                cubit.changeTransactionSliderValue),
                        SizedBox(
                          height: context.height * 0.039,
                        ),
                        AutoSizeText(
                          tr('withdraw_limit'),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: context.width * 0.04),
                        ),
                        SizedBox(
                          height: context.height * 0.013,
                        ),
                        SliderCardWidget(
                            sliderValue: cubit.withdrawSlider,
                            onChangeSliderValue:
                                cubit.changeWithdrawSliderValue),
                        const Spacer(),
                        LoadingButton(
                          isLoading: false,
                          title: tr('save'),
                          onTap: () {
                            cubit.setValues();
                            CustomNavigator.instance.pop();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
