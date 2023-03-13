import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/controller/cards_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/add_card/api/model/payment_method.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class PaymentMethodSheet extends StatelessWidget {
  const PaymentMethodSheet({
    super.key,
    required this.onAdded,
    this.onTap,
    this.hasBankAccounts = false,
  });

  final VoidCallback onAdded;
  final void Function(PaymentMethod paymentMethod)? onTap;
  final bool hasBankAccounts;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CardsCubit>.value(
      value: sl<CardsCubit>(),
      child: BlocBuilder<CardsCubit, CardsState>(
          builder: (BuildContext context, CardsState state) {
        if (state is GetPaymentMethodsLoading) {
          return const NativeLoading();
        } else {
          final CardsCubit cardController = context.read<CardsCubit>();
          return Column(
            children: cardController.paymentMethods
                    .map((PaymentMethod e) {
                      return ListTile(
                        onTap: onTap != null
                            ? () {
                                onTap!(e);
                              }
                            : () {
                                CustomNavigator.instance.pop();
                                CustomNavigator.instance.pushNamed(
                                  RoutesName.cardInfo,
                                  arguments: <String, dynamic>{
                                    "uuid": e.uuid,
                                    "callback": onAdded,
                                  },
                                );
                              },
                        leading: MyImage.svgAssets(
                          url: 'assets/icons/e_commerce/new_card.svg',
                          width: 20,
                          height: 20,
                        ),
                        title: Text(
                          e.name ?? "",
                          style: paragraphStyle,
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.black,
                        ),
                      );
                    })
                    .toList()
                    .cast<Widget>() +
                <Widget>[
                  if (hasBankAccounts)
                    ListTile(
                      onTap: () {
                        CustomNavigator.instance
                            .pushNamed(RoutesName.bankTransfer);
                      },
                      leading: MyImage.svgAssets(
                        url: "assets/icons/deposit/bank_transfer.svg",
                        width: 40,
                        height: 40,
                      ),
                      title: Text(
                        tr('bank_transfer'),
                        style: paragraphStyle,
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black,
                      ),
                    ),
                ],
          );
        }
      }),
    );
  }
}
