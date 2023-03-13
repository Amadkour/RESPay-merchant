import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';

import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';

import 'package:res_pay_merchant/core/services/navigation.dart';

import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/dropdown_widget.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/description_text_field.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/controller/orders_cubit.dart';

class ComplainOrderSheetWidget extends StatelessWidget {
  const ComplainOrderSheetWidget({
    super.key,
    this.onComplainTypeChanged,
    this.onDescriptionChanged,
    required this.formKey,
  });
  final ValueChanged<String>? onComplainTypeChanged;
  final ValueChanged<String>? onDescriptionChanged;
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    final double availableWidth = context.width - 40;
    final OrdersCubit orderController = sl<OrdersCubit>();

    return BlocProvider<OrdersCubit>.value(
      value: orderController,
      child: Padding(
        padding: EdgeInsets.only(
            top: 20, bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              CustomDropdown<String>(
                key: complainReasonKey,
                value: orderController.complainReasonType,
                color: Colors.white,
                borderColor: AppColors.borderColor,
                label: tr('complain_category'),
                items: const <String>["Inappropriate items"],
                onChanged: (String? v) => onComplainTypeChanged?.call(v!),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: DescriptionTextfield(
                  key: descriptionTextfieldKey,
                  onChanged: onDescriptionChanged,
                ),
              ),
              BlocBuilder<OrdersCubit, OrdersState>(
                builder: (BuildContext context, OrdersState state) => Row(
                  children: List<Widget>.generate(
                    3,
                    (int index) => Stack(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            orderController.addImage(index);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              width: (availableWidth / 3).floor() - 10,
                              height: (availableWidth / 3).floor() - 10,
                              margin: const EdgeInsetsDirectional.only(end: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: AppColors.borderColor,
                                ),
                              ),
                              child: orderController
                                      .complainFiles[index].isNotEmpty
                                  ? MyImage.file(
                                      url: orderController.complainFiles[index],
                                      fit: BoxFit.cover,
                                    )
                                  : Center(
                                      child: MyImage.svgAssets(
                                        url: 'assets/icons/orders/add.svg',
                                        width: 30,
                                        height: 30,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        if (orderController.complainFiles[index].isNotEmpty)
                          Positioned.directional(
                            end: 10,
                            textDirection: isArabic
                                ? TextDirection.rtl
                                : TextDirection.ltr,
                            child: InkWell(
                              onTap: () {
                                orderController.removeImages(index);
                              },
                              child: Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: AppColors.redColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: MyImage.svgAssets(
                                    url: "assets/icons/trash.svg",
                                    width: 15,
                                    height: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32, bottom: 12),
                child: BlocBuilder<OrdersCubit, OrdersState>(
                  builder: (BuildContext context, OrdersState state) =>
                      LoadingButton(
                    hasBottomSaveArea: false,
                    key: sheetApplyButtonKey,
                    isLoading: false,
                    title: tr('apply'),
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        await orderController.complain();
                        CustomNavigator.instance.pop();
                      }
                    },
                  ),
                ),
              ),
              Center(
                child: TextButton(
                  key: sheetCancelButtonKey,
                  onPressed: () {
                    CustomNavigator.instance.pop();
                  },
                  child: Text(
                    tr('cancel'),
                    style: buttonsStyle.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
