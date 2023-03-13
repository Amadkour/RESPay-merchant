import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/alternative_widgets/empty_widget.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/controller/beneficiary_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/gift/controller/gift_cubit/gift_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/gift/provider/model/received_gift_model.dart';
import 'package:res_pay_merchant/features/payment/modules/gift/view/component/gift_item.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/transfer_details/text_field_label.dart';

class ReceivedGifts extends StatelessWidget {
  const ReceivedGifts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GiftCubit>.value(
      value: sl<GiftCubit>()..getReceiveGifts(),
      child: BlocBuilder<GiftCubit, GiftState>(
        builder: (BuildContext context, GiftState state) {
          if (state is GetGiftLoadingState) {
            return const Center(
              child: NativeLoading(),
            );
          }
          final List<ReceivedGiftModel> filtered = sl<GiftCubit>()
              .searchInReceivedGifts(
                  sl<BeneficiaryCubit>().searchBarController.text);
          return Container(
              width: context.width,
              height: context.height,
              color: AppColors.lightWhite,
              padding: const EdgeInsets.all(20),
              child: filtered.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        buildLabel(label: "today"),
                        const SizedBox(
                          height: 8,
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemBuilder: (BuildContext context, int index) =>
                                  GiftItem(
                                      giftModel: ReceivedGiftModel(
                                          gift: filtered[index].gift,
                                          createdAt:
                                              filtered[index].createdAt)),
                              itemCount: filtered.length),
                        ),
                      ],
                    )
                  : SingleChildScrollView(
                      child: EmptyWidget(
                        height: 150,
                        message: tr("No Received Gifts Yet"),
                      ),
                    ));
        },
      ),
    );
  }
}
