import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/alternative_widgets/empty_widget.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/controller/transfer_options/transfer_options_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/transfer_to/build_custom_title.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/transfer_to/build_list_of_transfer_types.dart';

class TransferListBottomSheet extends StatelessWidget {
  const TransferListBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransferOptionsCubit>.value(
      value: sl<TransferOptionsCubit>()..get(),
      child: BlocBuilder<TransferOptionsCubit, TransferOptionsState>(
          builder: (BuildContext context, TransferOptionsState state) {
        final TransferOptionsCubit transCubit =
            context.read<TransferOptionsCubit>();
        if (state is TransferOptionsErrorState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            MyToast("Connection Error Or Server Error Happen");
          });
        }
        if (state is TransferOptionsLoadingState) {
          return const NativeLoading();
        }
        if (state is TransferOptionsErrorState) {
          return Container();
        }
        return Container(
          decoration: BoxDecoration(
            color: AppColors.lightWhite,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          ),
          padding: const EdgeInsets.all(20),
          child: MainScaffold(
            backgroundColor: Colors.transparent,
            scaffold: SingleChildScrollView(
              child: Wrap(
                children: <Widget>[
                  const SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: Container(
                      width: 64,
                      decoration: BoxDecoration(
                        color: AppColors.bottomSheetIconColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                      ),
                      height: 5,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(tr("Select Transfer"),
                      style: TextStyle(
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 16)),
                  Container(height: 10),
                  TransferTypeTitle(title: tr('INTERNATIONAL TRANSFER')),
                  Container(height: 10),
                  if (transCubit.internationalTransferTypes!.isEmpty)
                    EmptyWidget(
                      height: 80,
                      message: tr("No International Transfers Yet"),
                    )
                  else
                    BuildListOfTransferTypes(
                        title: tr('INTERNATIONAL TRANSFER'),
                        types: transCubit.internationalTransferTypes!),
                  Container(height: 30),
                  TransferTypeTitle(title: tr("LOCAL TRANSFER")),
                  Container(height: 10),
                  if (transCubit.internationalTransferTypes!.isEmpty)
                    EmptyWidget(
                      height: 80,
                      message: tr("No Local Transfers Yet"),
                    )
                  else
                    BuildListOfTransferTypes(
                        title: tr("LOCAL TRANSFER"),
                        types: transCubit.localTransferTypes!),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
