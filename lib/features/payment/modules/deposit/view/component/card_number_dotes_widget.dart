import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';

class CardNumberDotesWidget extends StatelessWidget {
  const CardNumberDotesWidget({
    super.key,
    required this.cardNumber,
  });
  final String cardNumber;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment:
            isArabic ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: List<Widget>.generate(3, (int index) {
              return Padding(
                padding: const EdgeInsetsDirectional.only(end: 9),
                child: Row(
                    children: List<Widget>.generate(4, (int index) {
                  return Container(
                    width: 3,
                    height: 3,
                    margin: const EdgeInsetsDirectional.only(
                      end: 2,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                  );
                })),
              );
            }) +
            <Text>[
              Text(cardNumber.substring(12)),
            ],
      ),
    );
  }
}
