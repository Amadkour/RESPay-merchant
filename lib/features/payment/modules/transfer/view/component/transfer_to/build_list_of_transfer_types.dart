import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/features/payment/modules/bank_name/controller/bank_name_controller/bank_name_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/controller/beneficiary_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/controller/transfer_options/transfer_options_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/transfer_to/transfer_item.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class BuildListOfTransferTypes extends StatelessWidget {
  final List<String> types;
  final String title;
  const BuildListOfTransferTypes({
    super.key,
    required this.title,
    required this.types,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            key: Key(
                "${types[index].replaceAll(" ", "").toLowerCase()}_${title.replaceAll(" ", "_").toLowerCase()}"),
            onTap: () {
              if (title == tr('INTERNATIONAL TRANSFER')) {
                sl<BeneficiaryCubit>().setCurrentTransferTapIndex(0);
              } else {
                sl<BeneficiaryCubit>().setCurrentTransferTapIndex(1);
              }
              sl<BankNameCubit>().reset();
              sl<BeneficiaryCubit>().configurationWhenTransferMethodChanged(
                  types[index],
                  sl<BeneficiaryCubit>().currentTransferTypeTapIndex);
              context
                  .read<TransferOptionsCubit>()
                  .setCurrentMethodType(types[index]);

              CustomNavigator.instance
                  .pushNamed(RoutesName.internationalResApp);
            },
            child: TransferItem(
              transferType: types[index],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 12,
          );
        },
        itemCount: types.length);
  }
}
