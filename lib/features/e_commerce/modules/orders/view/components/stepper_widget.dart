import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/widget/dotted_line_widget.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/controller/orders_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/model/order_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/model/tracking_stage_model.dart';

class StepperWidget extends StatelessWidget {
  const StepperWidget({
    super.key,
    required this.order,
  });

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            tr('status_details'),
            style: smallStyle,
          ),
        ),
        Column(
          children: List<Widget>.generate(order.timeline.length, (int index) {
            final TrackingStageModel stage = order.timeline.elementAt(index);

            final bool completed = index < order.timeline.length - 1;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${DateFormat("dd MMM").format(stage.date)} \n ${DateFormat('HH:mm').format(stage.date)}",
                  textAlign: TextAlign.start,
                  style: smallStyle.copyWith(
                    color: !completed ? Colors.grey : AppColors.greenColor,
                    height: 1.4,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: !completed
                              ? AppColors.stepperCompletedColor
                              : AppColors.greenColor.withOpacity(0.2),
                        ),
                        child: !completed
                            ? Center(
                                child: Container(
                                  width: 5,
                                  height: 5,
                                  decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              )
                            : Icon(
                                Icons.check,
                                size: 8,
                                color: AppColors.greenColor,
                              ),
                      ),
                      if (index < order.timeline.length - 1)
                        const SizedBox(
                          height: 48,
                          child: VerticalDivider(
                            color: Colors.grey,
                          ),
                        ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      stage.status,
                      style: smallStyle.copyWith(
                        color: !completed
                            ? AppColors.darkGrayColor
                            : AppColors.greenColor,
                      ),
                    ),
                    Text(
                      stage.description,
                      style: smallStyle.copyWith(
                        color: !completed
                            ? AppColors.darkGrayColor
                            : AppColors.greenColor,
                        fontWeight: FontWeight.normal,
                      ),
                    )
                  ],
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}

class HorizontalStepper extends StatelessWidget {
  const HorizontalStepper({super.key, required this.orderController});
  final OrdersCubit orderController;

  @override
  Widget build(BuildContext context) {
    final bool isRefunded = orderController.order.status == "returned";

    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: isRefunded ? 20 : 48, vertical: 10),
      child:
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        const Expanded(
          child: HorizontalStepperItem(
            text: "order",
            passed: true,
            hasDivider: true,
          ),
        ),
        Expanded(
          child: HorizontalStepperItem(
            text: "delivery",
            passed: orderController.orderShipped,
            hasDivider: true,
            icon: "assets/icons/e_commerce/delivery.svg",
          ),
        ),
        Expanded(
          flex: isRefunded ? 1 : 0,
          child: HorizontalStepperItem(
            text: "arrived",
            passed: orderController.orderCompleted,
            hasDivider: isRefunded,
            icon: "assets/icons/e_commerce/completed.svg",
          ),
        ),
        if (isRefunded)
          const Expanded(
            flex: 0,
            child: HorizontalStepperItem(
              text: "refund",
              passed: true,
              hasDivider: false,
            ),
          ),
      ]),
    );
  }
}

class HorizontalStepperItem extends StatelessWidget {
  const HorizontalStepperItem({
    required this.text,
    required this.passed,
    required this.hasDivider,
    this.icon,
  });
  final String text;
  final String? icon;
  final bool passed;
  final bool hasDivider;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              width: 35,
              height: 35,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: !passed
                    ? Colors.white
                    : AppColors.greenColor.withOpacity(0.1),
                border: !passed
                    ? Border.all(
                        color: AppColors.stepperCompletedColor,
                      )
                    : null,
              ),
              child: passed || icon == null
                  ? Icon(
                      Icons.check_circle,
                      color: passed
                          ? AppColors.greenColor
                          : AppColors.stepperCompletedColor,
                      size: 20,
                    )
                  : Center(
                      child: SvgPicture.asset(
                        icon!,
                        width: 25,
                        height: 25,
                        color: AppColors.greyColor,
                      ),
                    ),
            ),
            Text(
              tr(text),
              style: bodyStyle.copyWith(
                color: passed ? AppColors.greenColor : AppColors.greyColor,
              ),
            ),
          ],
        ),
        if (hasDivider)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 18),
              child: passed
                  ? Divider(
                      color: AppColors.greenColor,
                    )
                  : CustomPaint(
                      painter: DashedLinePainter(),
                    ),
            ),
          ),
      ],
    );
  }
}
