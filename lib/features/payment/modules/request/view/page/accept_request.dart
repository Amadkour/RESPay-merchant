import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/alternative_widgets/empty_widget.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/view/page/orders_page.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/controller/beneficiary_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/request/controller/request_cubit/request_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/request/controller/request_cubit/request_state.dart';
import 'package:res_pay_merchant/features/payment/modules/request/provider/model/money_request_filter_enum.dart';
import 'package:res_pay_merchant/features/payment/modules/request/provider/model/money_requests_model.dart';
import 'package:res_pay_merchant/features/payment/modules/request/view/component/single_request_item.dart';

class AcceptRequest extends StatefulWidget {
  const AcceptRequest({super.key});

  @override
  State<AcceptRequest> createState() => _AcceptRequestState();
}

class _AcceptRequestState extends State<AcceptRequest> {
  @override
  void initState() {
    super.initState();
    sl<RequestCubit>().getMoneyRequests();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
        scaffold: BlocProvider<RequestCubit>.value(
      value: sl<RequestCubit>(),
      child: BlocBuilder<RequestCubit, RequestState>(
        builder: (BuildContext context, RequestState state) {
          final RequestCubit requestCubit = sl<RequestCubit>();
          if (state is RequestLoadingState) {
            return const NativeLoading();
          }
          final List<RequestModel> filtered =
              requestCubit.searchInReceivedRequests(
                  sl<BeneficiaryCubit>().searchBarController.text);
          return Container(
              width: context.width,
              height: context.height,
              color: AppColors.lightWhite,
              child: requestCubit.moneyRequestsModel.requests!.isNotEmpty
                  ? SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                                start: 20, top: 20),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  children: MoneyRequestFilterEnum.values
                                      .map((MoneyRequestFilterEnum e) {
                                return OrderStatusFilterWidget(
                                  key: ValueKey<MoneyRequestFilterEnum>(e),
                                  name: e.name,
                                  isActive: requestCubit.filterStatus == e,
                                  onPressed: () {
                                    requestCubit.filterStatus = e;
                                  },
                                );
                              }).toList()),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          if (filtered.isNotEmpty) ...<Widget>[
                            ...List<Widget>.generate(filtered.length,
                                (int index) {
                              final RequestModel request = filtered[index];
                              final Color color = request.status ==
                                      MoneyRequestFilterEnum.rejected
                                  ? AppColors.redColor
                                  : request.status ==
                                          MoneyRequestFilterEnum.accepted
                                      ? AppColors.greenColor
                                      : AppColors.orange;
                              return SingleRequestItem(
                                  request: request, color: color);
                            })
                          ] else ...<Widget>[
                            EmptyWidget(
                              height: 150,
                              message: tr("No Requests Found"),
                            )
                          ]
                        ],
                      ),
                    )
                  : EmptyWidget(
                      height: 150,
                      message: tr("No Received Requests Yet"),
                    ));
        },
      ),
    ));
  }
}
