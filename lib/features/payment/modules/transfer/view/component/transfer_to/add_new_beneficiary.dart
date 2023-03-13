import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/decoration_values.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/constants.dart';
import 'package:res_pay_merchant/features/payment/modules/gift/controller/gift_cubit/gift_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/request/controller/request_cubit/request_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/transfer_to/show_transfer_list_bottom_sheet.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class AddNewBeneficiary extends StatelessWidget {
  final ServiceType serviceType;
  const AddNewBeneficiary({super.key, required this.serviceType});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (serviceType == ServiceType.gift) {
          sl<GiftCubit>().reset();
          CustomNavigator.instance.pushNamed(RoutesName.addNewBeneficiaryGift);
        } else if (serviceType == ServiceType.request_money) {
          sl<RequestCubit>().reset();
          CustomNavigator.instance.pushNamed(
            RoutesName.addRequest,
          );
        } else {
          buildTransferListBottomSheet(context);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 65,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: defaultBorderRadius,
        ),
        width: double.infinity,
        child: Row(
          children: <Widget>[
            Container(
              width: 47.0,
              height: 55.0,
              decoration: BoxDecoration(
                color: AppColors.blueColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                  child: SvgPicture.asset("assets/icons/transfer/plusicon.svg",
                      width: 17, height: 17)),
            ),
            const SizedBox(
              width: 12,
            ),
            AutoSizeText(tr("Add beneficiary"),
                style: TextStyle(
                    fontSize: 14,
                    color: AppColors.blueColor,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
