import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';

import 'package:res_pay_merchant/core/res/theme/font_styles.dart';

import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/model/celebrity.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';

class CelebrityWidget extends StatelessWidget {
  const CelebrityWidget({
    super.key,
    required this.celebrity,
  });

  final Celebrity celebrity;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: celebrityWidgetKey,
      onTap: () {
        CustomNavigator.instance
            .pushNamed(RoutesName.celerityDetail, arguments: celebrity);
      },
      child: Column(
        children: <Widget>[
          MyImage.network(
            url: celebrity.image,
            width: 130,
            height: 130,
            fit: BoxFit.cover,
            borderRadius: 130,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 2),
            child: Text(
              celebrity.name ?? "",
              style: paragraphStyle,
            ),
          ),
          Text("${celebrity.productCount} ${tr('product')}")
        ],
      ),
    );
  }
}
