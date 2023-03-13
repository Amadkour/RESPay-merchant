//
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
// import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
// import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
// import 'package:res_pay_merchant/core/widget/images/my_image.dart';
// import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/controller/cards_cubit.dart';
// import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/provider/model/credit_card_model.dart';
//
// class CreditCardWidget extends StatelessWidget {
//   const CreditCardWidget(
//       {super.key,
//         required this.index,
//         this.cardsVisible,
//         required this.creditCardModels,
//         required this.onChangeVisible});
//
//   final int index;
//   final List<bool>? cardsVisible;
//   final List<CreditCardModel> creditCardModels;
//   final void Function(int index) onChangeVisible;
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<CardsCubit>.value(
//       value: sl<CardsCubit>(),
//       child: BlocBuilder<CardsCubit, CardsState>(
//         builder: (BuildContext context, CardsState state) {
//           final CardsCubit cubit = context.watch<CardsCubit>();
//           return SizedBox(
//             height: context.height * 0.24,
//             child: Stack(
//               children: <Widget>[
//                 MyImage.assets(
//                   width: context.width ,
//                   height: context.width *1.1,
//                   url: 'assets/images/home/cards/main-card.png',
//                   fit: BoxFit.contain,
//                 ),
//                 Positioned(
//                   top: context.height * 0.03,
//                   child: Padding(
//                     padding: EdgeInsets.only(left: context.width * 0.1,right:context.width * 0.1 ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         SizedBox(
//                           width: context.width * 0.65,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             mainAxisSize: MainAxisSize.min,
//                             children: <Widget>[
//                               // if(type.toUpperCase() == 'VISA')
//                               //   MyImage.assets(
//                               //     url: 'assets/images/home/cards/symbols.png',
//                               //     width: context.width * 0.1,
//                               //     height: context.width * 0.1,
//                               //   ),
//                               // if(type.toUpperCase() != 'VISA')
//                               MyImage.svgAssets(
//                                 url: 'assets/images/home/cards/mastercard.svg',
//                                 width: context.width * 0.07,
//                                 height: context.width * 0.07,
//                               ),
//                               IconButton(
//                                 onPressed: () {
//                                   onChangeVisible(cubit.index);
//                                 },
//                                 icon: Builder(
//                                   builder: (BuildContext context) {
//                                     return Icon(
//                                       cardsVisible![cubit.index]
//                                           ? Icons.visibility_outlined
//                                           : Icons.visibility_off_outlined,
//                                       color: AppColors.eyeVisibleColor,
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         AutoSizeText(
//                           tr('current_balance'),
//                           style: TextStyle(
//                               color: Colors.white, fontSize: context.width * 0.03),
//                         ),
//                         AutoSizeText(
//                           '3.792.00\$',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: context.width * 0.05),
//                         ),
//                         SizedBox(
//                           height: context.height * 0.01,
//                         ),
//                         SizedBox(
//                           width: context.width * 0.65,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   SizedBox(
//                                     width: context.width * 0.3,
//                                     height: context.height * 0.025,
//                                     child: AutoSizeText(
//                                       tr('debit_card_number'),
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: context.width * 0.03),
//                                     ),
//                                   ),
//
//                                   Directionality(
//                                     textDirection: TextDirection.ltr,
//                                     child: Row(
//                                       children: <Widget>[
//                                         cardsVisible![cubit.index]
//                                             ? Row(
//                                           children: <Widget>[
//                                             AutoSizeText(
//                                               '${creditCardModels[cubit.index].cardNumber!.substring(0, 4)}    ',
//                                               style: TextStyle(
//                                                   fontSize:
//                                                   context.width * 0.03,
//                                                   letterSpacing: 1.5,
//                                                   fontWeight:
//                                                   FontWeight.bold,
//                                                   color: Colors.white),
//                                             ),
//                                             AutoSizeText(
//                                               '${creditCardModels[cubit.index].cardNumber!.substring(4, 8)}    ',
//                                               style: TextStyle(
//                                                   fontSize:
//                                                   context.width * 0.03,
//                                                   letterSpacing: 1.5,
//                                                   fontWeight:
//                                                   FontWeight.bold,
//                                                   color: Colors.white),
//                                             ),
//                                             AutoSizeText(
//                                               '${creditCardModels[cubit.index].cardNumber!.substring(8, 12)}    ',
//                                               style: TextStyle(
//                                                   fontSize:
//                                                   context.width * 0.03,
//                                                   letterSpacing: 1.5,
//                                                   fontWeight:
//                                                   FontWeight.bold,
//                                                   color: Colors.white),
//                                             ),
//                                           ],
//                                         )
//                                             : MyImage.svgAssets(
//                                           url:
//                                           'assets/images/home/cards/points.svg',
//                                           width: context.width * 0.1,
//                                           height: context.height * 0.007,
//                                         ),
//                                         AutoSizeText(
//                                           creditCardModels[cubit.index]
//                                               .cardNumber!
//                                               .substring(12, 16),
//                                           style: TextStyle(
//                                               fontSize: context.width * 0.03,
//                                               letterSpacing: 1.5,
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.white),
//                                         )
//                                       ],
//                                     ),
//                                   )
//                                 ],
//                               ),
//                               Column(
//                                 children: <Widget>[
//                                   AutoSizeText(
//                                     tr('valid_thru'),
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: context.width * 0.03),
//                                   ),
//                                   AutoSizeText(
//                                     '${creditCardModels[cubit.index].expiryDate!.split('/')[0]}/${creditCardModels[cubit.index].expiryDate!.split('/')[1].substring(2, 4)}',
//                                     style: TextStyle(
//                                         fontSize: context.width * 0.03,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.white),
//                                   )
//                                 ],
//                               )
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/controller/cards_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/provider/model/credit_card_model.dart';

class CreditCardWidget extends StatelessWidget {
  const CreditCardWidget(
      {super.key,
      required this.index,
      this.cardsVisible,
      required this.creditCardModels,
      required this.onChangeVisible});

  final int index;
  final List<bool>? cardsVisible;
  final List<CreditCardModel> creditCardModels;
  final void Function(int index) onChangeVisible;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CardsCubit>.value(
      value: sl<CardsCubit>(),
      child: BlocBuilder<CardsCubit, CardsState>(
        builder: (BuildContext context, CardsState state) {
          final CardsCubit cubit = context.watch<CardsCubit>();
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Container(
              height: context.width * 0.5,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                children: <Widget>[
                  MyImage.assets(
                    url: 'assets/images/home/cards/main-card.png',
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: context.width * 0.03,
                        right: context.width * 0.03,
                        bottom: context.width * 0.01,
                        top: context.width * 0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // MyImage.assets(
                        //   width: context.width * 0.9,
                        //   height: context.height * 0.3,
                        //   url: '',
                        //   fit: BoxFit.contain,
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            // if(type.toUpperCase() == 'VISA')
                            //   MyImage.assets(
                            //     url: 'assets/images/home/cards/symbols.png',
                            //     width: context.width * 0.1,
                            //     height: context.width * 0.1,
                            //   ),
                            // if(type.toUpperCase() != 'VISA')
                            MyImage.svgAssets(
                              key: const Key("master_card_image"),
                              url: 'assets/images/home/cards/mastercard.svg',
                              width: context.width * 0.07,
                              height: context.width * 0.07,
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                onChangeVisible(cubit.index);
                              },
                              icon: Builder(
                                builder: (BuildContext context) {
                                  return Icon(
                                    cardsVisible![cubit.index]
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: AppColors.eyeVisibleColor,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        AutoSizeText(
                          tr('current_balance'),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                        const AutoSizeText(
                          '3.792.00\$',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Spacer(
                          flex: 3,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                AutoSizeText(
                                  tr('debit_card_number'),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Row(
                                    children: <Widget>[
                                      cardsVisible![cubit.index]
                                          ? Row(
                                              children: <Widget>[
                                                AutoSizeText(
                                                  '${creditCardModels[cubit.index].cardNumber!.substring(0, 4)}    ',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      letterSpacing: 1.5,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                                AutoSizeText(
                                                  '${creditCardModels[cubit.index].cardNumber!.substring(4, 8)}    ',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      letterSpacing: 1.5,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                                AutoSizeText(
                                                  '${creditCardModels[cubit.index].cardNumber!.substring(8, 12)}    ',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      letterSpacing: 1.5,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            )
                                          : MyImage.svgAssets(
                                              url:
                                                  'assets/images/home/cards/points.svg',
                                              width: context.width * 0.05,
                                              height: context.height * 0.006,
                                            ),
                                      AutoSizeText(
                                        creditCardModels[cubit.index]
                                            .cardNumber!
                                            .substring(12, 16),
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                AutoSizeText(
                                  tr('valid_thru'),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                                AutoSizeText(
                                  '${creditCardModels[cubit.index].expiryDate!.split('/')[0]}/${creditCardModels[cubit.index].expiryDate!.split('/')[1].substring(2, 4)}',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
