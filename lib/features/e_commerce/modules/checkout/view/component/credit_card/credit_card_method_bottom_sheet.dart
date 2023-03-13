import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/bottom_sheet/base_bottom_sheet.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/controller/hom_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/checkout/view/component/credit_card/cards_method_sheet.dart';

import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';

void showCreditCardsMethodBottomSheet({required BuildContext context}) {
  showCustomBottomSheet(
    context: context,
    padding: EdgeInsets.zero,
    margin: EdgeInsets.zero,
    hasButtons: false,
    body: SafeArea(
      child: Column(
        children: <Widget>[
          SingleChildScrollView(
            child: Material(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: const <Widget>[
                        SizedBox(
                          height: 20,
                        ),

                        /// Pay with res pay
                        // LoadingButton(
                        //   isLoading: false,
                        //   title: tr('pay_res_pay'),
                        //   fontWeight: FontWeight.w500,
                        //   fontColor: AppColors.blackColor,
                        //   borderColor: AppColors.borderColor,
                        //   backgroundColor: Colors.white,
                        //   topPadding: 0,
                        // ),
                        // const SizedBox(
                        //   height: 20,
                        // )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          ///My Cards
          const SizedBox(
            height: 20,
          ),
          BlocProvider<HomCubit>.value(
            value: sl<HomCubit>(),
            child: BlocBuilder<HomCubit, HomeState>(
              builder: (BuildContext context, HomeState state) {
                if (context.read<HomCubit>().homeCards!.isNotEmpty) {
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: SizedBox(
                          height: context.height * 0.16,
                          child: const CardsMethodSheet(),
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    ),
    title: tr('payment_method'),
  );
}
