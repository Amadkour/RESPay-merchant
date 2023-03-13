import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/providers/models/item_model.dart';

class UpperList extends StatelessWidget {
  final List<ItemModel> list;

  const UpperList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 75,
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: 10,
          );
        },
        itemCount: list.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            key: getMoreItemKey(list[index].text!),
            onTap: () {
              CustomNavigator.instance.pushNamed(list[index].navigateTo!);
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              height: 75,
              width: (context.width - 60) / 3,
              child: Row(
                children: <Widget>[
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          width: 30.0,
                          height: 30.0,
                          decoration: BoxDecoration(
                              color: Color(
                                int.parse(
                                  list[index].color!,
                                ),
                              ).withOpacity(0.1),
                              shape: BoxShape.circle),
                          child: Center(
                            child: ClipRRect(
                                child: MyImage.svgAssets(
                              borderRadius: 50.0,
                              url: list[index].imageUrl,
                              color: Color(int.parse(list[index].color!)),
                              width: 15.0,
                              height: 15.0,
                              fit: BoxFit.cover,
                            )),
                          ),
                        ),
                        Text(
                          tr(list[index].text!),
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.blackColor,
                              fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                      onTap: () {},
                      child: isArabic
                          ? RotatedBox(
                              quarterTurns: 2,
                              child: MyImage.svgAssets(
                                url: "assets/icons/transfer/rightarrow.svg",
                                height: 20,
                              ),
                            )
                          : MyImage.svgAssets(
                              url: "assets/icons/transfer/rightarrow.svg",
                              height: 20,
                            ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
