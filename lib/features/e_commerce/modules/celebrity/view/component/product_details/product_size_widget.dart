import 'package:flutter/material.dart';

import 'package:res_pay_merchant/core/res/theme/font_styles.dart';

import 'package:res_pay_merchant/features/e_commerce/provider/models/varient.dart';

import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';

import 'package:res_pay_merchant/core/res/theme/colors.dart';

class ProductSizeWidget extends StatelessWidget {
  const ProductSizeWidget(
      {super.key,
      required this.variantList,
      required this.onChanged,
      this.selectedVarient});

  final MapEntry<String, List<Variant>> variantList;
  final ValueChanged<Variant> onChanged;
  final Variant? selectedVarient;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          tr(variantList.key),
          style: paragraphStyle,
        ),
        Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 24),
            child: Row(
              children: variantList.value
                  .map(
                    (Variant size) => InkWell(
                      onTap: () {
                        onChanged(size);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsetsDirectional.only(end: 4),
                        height: 32,
                        constraints: const BoxConstraints(
                          minWidth: 32,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: selectedVarient?.uuid == size.uuid
                                ? AppColors.secondaryColor
                                : AppColors.backgroundColor,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            size.value,
                            style: selectedVarient?.uuid == size.uuid
                                ? smallStyle
                                : smallStyle.copyWith(
                                    fontWeight: FontWeight.normal,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList()
                  .cast<Widget>(),
            )),
      ],
    );
  }
}
