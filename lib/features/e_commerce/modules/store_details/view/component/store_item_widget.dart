import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';

import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/features/dashboard/modules/shop/provider/module/shop_model.dart';

class StoreItemWidget extends StatelessWidget {
  final Shops shops;
  const StoreItemWidget({super.key, required this.shops});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              ClipOval(
                child: MyImage.network(
                  height: 55,
                  width: 55,
                  url: shops.icon,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    shops.name!,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Online • Jakarta Barat",
                    style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff5A6367),
                        fontWeight: FontWeight.w600),
                  ),
                ],
              )
            ],
          ),
          Container(
            height: 1,
            color: const Color(0xffEDEDED),
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 16),
          ),
          Text(
            tr("description"),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 4,
          ),
          Html(data: shops.description ?? """"""),
          // AutoSizeText(
          //     style: const TextStyle(
          //         fontSize: 12,color: Color(0xff5A6367),fontWeight: FontWeight.w300
          //     ),
          //     shops.description!
          // )
        ],
      ),
    );
  }
}
