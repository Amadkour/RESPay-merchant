import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/model/celebrity.dart';

class CelebrityInfoWidget extends StatelessWidget {
  const CelebrityInfoWidget({
    super.key,
    required this.currentCelebrity,
  });

  final Celebrity currentCelebrity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: Colors.white,
      height: 95,
      child: Row(
        children: <Widget>[
          SizedBox(
            height: 60,
            width: 60,
            child: ClipOval(
              child: MyImage.network(
                height: 60,
                width: 60,
                url: currentCelebrity.image,
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            currentCelebrity.name ?? "",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
