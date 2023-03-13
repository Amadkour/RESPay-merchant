import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/dropdown_widget.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/account_num_text_field.dart';
import 'package:res_pay_merchant/features/payment/modules/pay_bill/controller/bill_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/pay_bill/view/page/bill_summery_page.dart';

class AddBillRequest extends StatelessWidget {
  const AddBillRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      /// TODO using BlocProvider.create causing error
      /// when otp completed and try to emit new state
      /// bill cubit was already closed because you
      /// was use BlocProvider.create
      scaffold: BlocProvider<BillCubit>.value(
        value: sl<BillCubit>(),
        child: BlocConsumer<BillCubit, BillState>(
          listener: (BuildContext context, BillState state) {
            if (state is PayBillErrorState) {
              MyToast(state.failure.message);
            }
          },
          builder: (BuildContext context, BillState state) {
            final BillCubit controller = context.read<BillCubit>();
            return Scaffold(
              resizeToAvoidBottomInset: true,
              extendBody: true,
              appBar: MainAppBar(
                title: tr('Add Request'),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      controller.state is BillTypesLoading
                          ? const NativeLoading()
                          : CustomDropdown<String>(
                              key: selectCompanyKey,
                              items: controller.billTypes.values.toList().cast<String>(),
                              onChanged: (String? value) {
                                controller.changeBank(value);
                              },
                              label: tr('Select Company'),
                              value: controller.billTypeModel,
                              color: Colors.white,
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      AccountNumText(
                        key: customerIdKey,
                        title: tr('customer_id'),
                        onChanged: (String v) {
                          controller.onCustomerIdChanged(v);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(24),
                child: LoadingButton(
                  key: seeBillKey,
                  enable: controller.buttonEnabled,
                  isLoading: controller.state is PayBillLoading,
                  title: tr('see_bill'),
                  onTap: () async {
                    if (controller.state is! BillRequestLoading) {
                      final bool result = await controller.getBill();
                      if (result) {
                        CustomNavigator.instance
                            .push(routeWidget: const BillSummery());
                      }
                    }
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
