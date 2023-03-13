import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards_credit_card/view/component/prepaid_list_item_widget.dart';


class PrepaidTab extends StatelessWidget {
  const PrepaidTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(children: <Widget>[
        const PrepaidListItemWidget(),
        SizedBox(height: context.height*0.04,),
        const PrepaidListItemWidget(),
      ],),
    );
  }
}
