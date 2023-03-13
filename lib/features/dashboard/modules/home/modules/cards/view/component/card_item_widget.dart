import 'package:flutter/material.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/provider/model/credit_card_model.dart';
import 'package:res_pay_merchant/features/payment/modules/deposit/view/component/card_icon_widget.dart';
import 'package:res_pay_merchant/features/payment/modules/deposit/view/component/card_number_dotes_widget.dart';

class CardItemWidget extends StatelessWidget {
  const CardItemWidget({
    super.key,
    required this.card,
    this.hasRadio = true,
    this.groupValue,
    this.onChanged,
  });

  final CreditCardModel card;
  final bool hasRadio;
  final CreditCardModel? groupValue;
  final ValueChanged<CreditCardModel>? onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CardIconWidget(
        type: card.type!,
      ),
      title: Text(card.type!.toUpperCase()),
      subtitle: CardNumberDotesWidget(
        cardNumber: card.cardNumber!,
      ),
      trailing: hasRadio
          ? Radio<CreditCardModel?>(
              value: card,
              groupValue: groupValue,
              onChanged: (CreditCardModel? v) {
                onChanged?.call(card);
              },
            )
          : null,
    );
  }
}
