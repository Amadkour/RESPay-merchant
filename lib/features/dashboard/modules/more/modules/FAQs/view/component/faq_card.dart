import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/FAQs/controllers/faq_cubit.dart';

class FrequentlyCard extends StatelessWidget {
  const FrequentlyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FaqCubit, FaqState>(
      builder: (BuildContext context, FaqState state) {
        final FaqCubit controller = context.read<FaqCubit>();
        if (state is FAQFailureSate) {
          return ErrorWidget.withDetails();
        }
        if (state is FreqLoading) {
          return SizedBox(
            height: context.height/2,
            child: const Center(
              child: NativeLoading(),
            ),
          );
        }
        if (state is FreqLoaded || state is ResetSearchbar) {
          return FaqListBody(controller: controller);
        }
        else{
          return ErrorWidget.withDetails();
        }
      },
    );
  }
}

class FaqListBody extends StatelessWidget {
  const FaqListBody({
    super.key,
    required this.controller,
  });

  final FaqCubit controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, right: 20, left: 20, bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            tr('freq_asked'),
            style: TextStyle(
                color: AppColors.blackColor,
                fontWeight: FontWeight.w500,
                fontSize: 12,
                fontFamily: 'Bold'),
          ),
          const SizedBox(
            height: 22,
          ),
          ...List<Widget>.generate(
            controller.faqFilteredList.length,
            (int index) => SingleFAQItem(controller: controller,index: index),
          )
        ],
      ),
    );
  }
}

class SingleFAQItem extends StatelessWidget {
  const SingleFAQItem({
    super.key,
    required this.controller,
    required this.index
  });

  final FaqCubit controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: Key('faq_tab$index'),

      onTap: () {
        controller.onClick(index);
      },
      child: AnimatedContainer(
        margin: const EdgeInsets.only(bottom: 12),
        width: double.maxFinite,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:<Widget> [
                Expanded(
                  child: AutoSizeText(
                    controller.faqFilteredList[index].question ?? '',
                    maxFontSize: 14,
                    minFontSize: 10,
                    style: TextStyle(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        fontFamily: 'plain'),
                    maxLines: 3,
                  ),
                ),
                RotatedBox(
                  quarterTurns: controller.faqFilteredList[index].isOpen
                      ? 1
                      : isArabic
                      ? 0
                      : 2,
                  child:
                  Text(
                    String.fromCharCode(Icons.arrow_back_ios.codePoint),
                    style: TextStyle(
                      inherit: false,
                      color: AppColors.blackColor,
                      fontSize: MediaQuery.of(context).size.width* 0.04,
                      fontWeight: FontWeight.w700,
                      fontFamily: Icons.close.fontFamily,
                      package: Icons.close.fontPackage,
                    ),
                  ),
                ),
              ],
            ),
            if (controller.faqFilteredList[index].isOpen)
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(

                  controller.faqData.faqs[index].answer ?? '',
                  style: TextStyle(
                      color: AppColors.withdrawTextColor.withOpacity(0.7),
                      fontSize: 12,
                      fontFamily: 'plain'),
                  maxLines: 3,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
