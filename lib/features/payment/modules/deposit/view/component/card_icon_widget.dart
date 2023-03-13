import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';

class CardIconWidget extends StatelessWidget {
  const CardIconWidget({
    super.key,
    required this.type,
  });
  final String type;
  @override
  Widget build(BuildContext context) {
    // return Container(
    //   width: 34,
    //   height: 34,
    //   decoration: BoxDecoration(
    //     color: Colors.red.withOpacity(0.1),
    //     shape: BoxShape.circle,
    //   ),
    //   child: Center(
    //     child: MyImage.svgAssets(
    //       url: type != "visa" ? "assets/icons/mastercard.svg" : "assets/icons/visa.svg",
    //       width: 20,
    //       height: 20,
    //     ),
    //   ),
    // );
    return MyImage.assets(
      url: type.toLowerCase() == "visa"
          ? "assets/icons/credit_card_types/visa.png"
          : type.toLowerCase() == "mastercard"
              ? "assets/icons/credit_card_types/mastercard.png"
              : "assets/icons/credit_card_types/mada.png",
      width: 40,
      height: 40,
    );
  }
}
