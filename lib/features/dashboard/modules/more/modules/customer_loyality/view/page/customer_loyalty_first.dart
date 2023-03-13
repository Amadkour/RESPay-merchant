import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/customer_loyality/controller/customer_loyalty_cubit.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class MainCustomerLoyalty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CustomerLoyaltyCubit>.value(
      value: sl<CustomerLoyaltyCubit>()..onInit(),
      child: BlocConsumer<CustomerLoyaltyCubit, CustomerLoyaltyState>(
        listener: (BuildContext context, CustomerLoyaltyState state) {
          if (state is CustomerLoyaltyError) {
            MyToast(state.failure.message);
          }
        },
        builder: (BuildContext context, CustomerLoyaltyState state) {
          final CustomerLoyaltyCubit controller = context.read<CustomerLoyaltyCubit>();
          return MainScaffold(
              scaffold: Scaffold(
            appBar: MainAppBar(
              title: tr('customer_loyalty'),
              backgroundColor: Colors.white,
            ),
            body: Builder(builder: (BuildContext context) {
              if (state is CustomerLoyaltyLoading) {
                return const NativeLoading();
              }
              return MainCustomerLoyaltyBody(controller: controller);
            }),
          ));
        },
      ),
    );
  }
}

class MainCustomerLoyaltyBody extends StatelessWidget {
  final CustomerLoyaltyCubit controller;
  const MainCustomerLoyaltyBody({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(tr("list_store"),
                style: TextStyle(fontSize: 16, color: AppColors.blackColor, fontFamily: 'Bold')),
            const SizedBox(
              height: 18,
            ),
            ...List<Widget>.generate(controller.customerList.length, (int index) {
              return SingleCustomerLoyalty(
                controller: controller,
                index: index,
              );
            })
          ],
        ),
      ),
    );
  }
}

class SingleCustomerLoyalty extends StatelessWidget {
  const SingleCustomerLoyalty({super.key, required this.index, required this.controller});
  final CustomerLoyaltyCubit controller;

  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: InkWell(
        key: Key('item_check_key$index'),
        onTap: () {
          controller.show(controller.customerList.elementAt(index));
          CustomNavigator.instance.pushNamed(RoutesName.customerLoyaltyRate);
        },
        child: Container(
          padding: const EdgeInsets.only(left: 14, right: 14, top: 20, bottom: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: SizedBox(
              width: 45,
              height: 45,
              child: MyImage.network(
                url: controller.customerList[index].icon,
                height: 45,
                width: 45,
                borderRadius: 45,
              ),
            ),
            title: Text(
              controller.customerList[index].title.toString(),
              style: TextStyle(fontSize: 16, color: AppColors.blackColor, fontFamily: 'Bold'),
            ),
            subtitle: Text(
              '${controller.customerList[index].rate.toString()}/6 Stamp Remaining',
              style: TextStyle(fontSize: 12, color: AppColors.textColor3, fontFamily: 'Plain'),
            ),
          ),
        ),
      ),
    );
  }
}
