import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/controller/hom_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/controller/cards_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/view/page/cards_page.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/view/component/general_add_new_widget.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class MyCardsPage extends StatelessWidget {
  const MyCardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CardsCubit>.value(
      value: sl<CardsCubit>(),
      child: BlocBuilder<CardsCubit, CardsState>(
        builder: (BuildContext context, CardsState cardsState) {
          return BlocProvider<HomCubit>.value(
            value: sl<HomCubit>(),
            child: BlocBuilder<HomCubit, HomeState>(
                builder: (BuildContext context, HomeState state) {
              final HomCubit controller = BlocProvider.of(context);
              if (state is HomeLoading || cardsState is CardsLoading) {
                return const Center(
                  child: NativeLoading(),
                );
              }
              return Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      AutoSizeText(
                        tr('my_cards'),
                        style: TextStyle(
                            fontSize: 16,
                            color: AppColors.blackColor,
                            fontFamily: 'Bold',
                            fontWeight: FontWeight.w500),
                      ),
                      InkWell(
                        key: viewMoreCardsKey,
                        onTap: () {
                          CustomNavigator.instance.pushNamed(RoutesName.cards);
                        },
                        child: Row(
                          children: <Widget>[
                            AutoSizeText(
                              tr('view_more'),
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff2C64E3),
                                  fontFamily: 'Bold',
                                  fontWeight: FontWeight.w500),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_sharp,
                              color: Color(0xff2C64E3),
                              size: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 130,
                    width: double.infinity,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List<Widget>.generate(
                            controller.homeCards?.length ?? 0,
                            (int index) => Padding(
                                  padding: EdgeInsets.only(
                                      top: 15,
                                      right: !isArabic ? 15 : 0,
                                      left: !isArabic ? 0 : 15),
                                  child: InkWell(
                                    onTap: () {
                                      /// Go to CardsPage and pass the index to show the selected card
                                      CustomNavigator.instance.push(
                                          routeWidget: CardsPage(
                                        index: index,
                                      ));
                                    },
                                    child: Container(
                                      width: 130,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                MyImage.svgAssets(
                                                  url: controller.homeCards![0]
                                                              .type!
                                                              .toUpperCase() ==
                                                          'MASTERCARD'
                                                      ? 'assets/images/home/master_card.svg'
                                                      : 'assets/images/home/visa.svg',
                                                  height: 38,
                                                  width: 38,
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Text(tr('card_number'),
                                                    style: TextStyle(
                                                        fontFamily: 'Plain',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 10,
                                                        color: AppColors
                                                            .otpBorderColor)),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Directionality(
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  child: Row(
                                                    children: <Widget>[
                                                      ...List<Widget>.generate(
                                                          4,
                                                          (int index) =>
                                                              Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .all(2),
                                                                height: 5,
                                                                width: 5,
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: AppColors
                                                                        .blackColor),
                                                              )),
                                                      Text(
                                                          controller
                                                              .homeCards![index]
                                                              .cardNumber!
                                                              .substring(controller
                                                                      .homeCards![
                                                                          index]
                                                                      .cardNumber!
                                                                      .length -
                                                                  4),
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Plain',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 12,
                                                              color: AppColors
                                                                  .blackColor)),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios_sharp,
                                              size: 13,
                                              color: AppColors.blackColor,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ))
                          ..add(GeneralAddNewWidget(
                            title: tr("add_new_card"),
                            onPressed: () {
                              CustomNavigator.instance.pushNamed(
                                  RoutesName.cardInfo,
                                  arguments: <String, dynamic>{
                                    "callback": () =>
                                        CustomNavigator.instance.pop(),
                                  });
                            },
                          )),
                      ),
                    ),
                  ),
                ],
              );
            }),
          );
        },
      ),
    );
  }
}
