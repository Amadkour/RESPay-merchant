import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/e_commerce/provider/models/product_model.dart';
import 'package:res_pay_merchant/features/e_commerce/view/component/product/product_item_in_row_view.dart';

class HotDeals extends StatelessWidget {
  final List<ParentModel> hotDeals;
  const HotDeals({
    super.key,required this.hotDeals
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: hotDeals.length==1?100:188,
      child: GridView.builder(
        padding: EdgeInsets.zero,
        itemCount: hotDeals.length,
        itemBuilder: (BuildContext context, int index) {
          return ProductItemInRowView(product: hotDeals[index] as ProductModel,itemIndex: index,);
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: hotDeals.length==1?1:2,
          childAspectRatio: 0.3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12
        ),
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
