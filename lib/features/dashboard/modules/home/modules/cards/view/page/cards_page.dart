import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/configuration/top_level_configuration.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/alternative_widgets/empty_widget.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/dialogs/confitm_cancel_dialog.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/controller/hom_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/controller/card_limit/card_limit_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/controller/cards_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/view/component/cards_list_widget.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/view/component/details_card_widget.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/view/component/other_features_widget.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class CardsPage extends StatelessWidget {
  const CardsPage({super.key, this.index});

  final int? index;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<CardLimitCubit>.value(
          value: sl<CardLimitCubit>(),
        ),
        BlocProvider<HomCubit>.value(
          value: sl<HomCubit>(),
        ),
        BlocProvider<CardsCubit>.value(
          value: sl<CardsCubit>(),
        ),
      ],
      child: BlocBuilder<HomCubit, HomeState>(
        builder: (BuildContext context, HomeState state) {
          return BlocBuilder<CardsCubit, CardsState>(
            builder: (BuildContext context, CardsState state) {
              final CardsCubit cubit = BlocProvider.of(context);
              return MainScaffold(
                  appBarWidget: MainAppBar(
                    title: 'my_cards',
                    onBack: () {
                      CustomNavigator.instance.pop();
                    },
                    actions: Row(
                      children: <Widget>[
                        IconButton(
                          key: addCardKey,
                          onPressed: () {
                            CustomNavigator.instance.pushNamed(
                                RoutesName.cardInfo,
                                arguments: <String, dynamic>{
                                  "callback": () =>
                                      CustomNavigator.instance.pop(),
                                });
                          },
                          icon: const Icon(Icons.add),
                        ),
                        if (showRESPayButton)
                          TextButton(
                            onPressed: state is CardsInitial
                                ? null
                                : () {
                                    CustomNavigator.instance.pushNamed(
                                        RoutesName.cardCreditCard,
                                        arguments: cubit.creditCardModels);
                                  },
                            child: AutoSizeText(
                              'RESPay Card',
                              style: TextStyle(color: AppColors.blueColor2),
                            ),
                          )
                      ],
                    ),
                  ),
                  scaffold: CardsBody(
                    cubit: cubit,
                    index: index,
                    state: state,
                  ));
            },
          );
        },
      ),
    );
  }
}

class CardsBody extends StatelessWidget {
  const CardsBody(
      {super.key,
      required this.cubit,
      required this.index,
      required this.state});

  final CardsCubit cubit;
  final int? index;
  final CardsState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: context.width * 0.05,
        left: context.width * 0.05,
        bottom: context.height * 0.05,
        top: context.height * 0.02,
      ),
      child: Builder(builder: (BuildContext context) {
        /// --------------- Loading Cards
        if (state is CardsLoading) {
          return const Center(child: NativeLoading());

          ///--------------- No Cards
        } else if (cubit.creditCardModels.isEmpty) {
          return Center(
            child: EmptyWidget(
              message: 'No cards added yet',
              height: context.height * 0.3,
              width: context.width,
            ),
          );
        }
        return SingleChildScrollView(
            key: cardsListKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    CardsListWidget(
                        type: cubit.creditCardModels[cubit.index].type!,
                        externalIndex: index,
                        pageViewController: cubit.pageViewController,
                        currentIndex: cubit.index,
                        cardsVisible: cubit.cardsVisible,
                        onChangeVisible: cubit.onChangeCardVisibility,
                        creditCardModels: cubit.creditCardModels,
                        onPageChanged: cubit.onPageChanged),
                    SizedBox(
                      height: context.height * 0.01,
                    ),
                    DetailsCardWidget(
                      cubit: cubit,
                    ),
                  ],
                ),
                SizedBox(
                  height: context.height * 0.02,
                ),
                OtherFeaturesWidget(
                  cubit: cubit,
                ),
                Center(
                  child: BlocConsumer<CardsCubit, CardsState>(
                    listener: (BuildContext context, CardsState state) {
                      if (state is CardsFailure) {
                        MyToast(state.failure.message);
                      }
                      if (state is CardDeletedState) {
                        MyToast(tr("card_deleted"),
                            background: AppColors.greenColor);
                      }
                    },
                    builder: (BuildContext context, CardsState state) =>
                        LoadingButton(
                      key: deleteCardButtonKey,
                      isLoading: state is CardsLoading,
                      onTap: () async {
                        ConfirmCancelDialog(
                            context: context,
                            title: tr('sure_delete_card'),
                            onConfirm: () {
                              cubit.deleteCard(index ?? cubit.index);
                            });
                      },
                      title: tr('delete_card'),
                    ),
                  ),
                ),
              ],
            ));
      }),
    );
  }
}
