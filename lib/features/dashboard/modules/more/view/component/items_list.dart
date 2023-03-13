import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/dialogs/guest_dialog.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/authentication/modules/pin_code/controller/pin_code_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/providers/models/item_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/view/component/more_item.dart';

class ListOfItems extends StatelessWidget {
  final List<ItemModel> items;
  final bool? isAuthorized;

  const ListOfItems({super.key, required this.items, this.isAuthorized});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PinCodeCubit>.value(
      value: sl<PinCodeCubit>()..init(),
      child: BlocConsumer<PinCodeCubit, PinCodeState>(
        listener: (BuildContext context, PinCodeState state) {
          if (state is BiometricError) {
            MyToast(state.failure.message);
          }
        },
        builder: (BuildContext context, PinCodeState state) {
          final PinCodeCubit pinCodeController = context.read<PinCodeCubit>();

          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              late Widget? item;
              if (tr(items[index].text!) == tr("face_id") && pinCodeController.hasFaceId) {
                item = MoreItem(
                  loading: state is BioMetricLoading && state.index == 2,
                  switchValue: pinCodeController.faceIdEnabled,
                  item: items[index],
                  fontWeight: FontWeight.w400,
                  onSwitchChanged: (bool value) {
                    pinCodeController.setCurrentFaceId(state: value);
                  },
                );
              } else if (tr(items[index].text!) == tr("fingerprint") &&
                  pinCodeController.hasFingerPrintId) {
                item = MoreItem(
                  loading: state is BioMetricLoading && state.index == 3,
                  switchValue: pinCodeController.fingerPrintEnabled,
                  item: items[index],
                  fontWeight: FontWeight.w400,
                  onSwitchChanged: (bool value) {
                    log(value.toString());
                    pinCodeController.setCurrentFingerPrint(state: value);
                  },
                );
              } else if (tr(items[index].text!) != tr("fingerprint") &&
                  tr(items[index].text!) != tr("face_id")) {
                item = MoreItem(
                  item: items[index],
                  fontWeight: FontWeight.w400,
                );
              } else {
                item = const SizedBox();
              }
              return isAuthorized == null || isAuthorized! ? item : GuestDialog(child: item);
            },
          );
        },
      ),
    );
  }
}
