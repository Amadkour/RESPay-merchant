import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/dialogs/confitm_cancel_dialog.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/features/payment/modules/request/controller/request_cubit/request_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/request/controller/request_cubit/request_state.dart';
import 'package:res_pay_merchant/features/payment/modules/request/provider/model/money_request_filter_enum.dart';
import 'package:res_pay_merchant/features/payment/modules/request/provider/model/money_requests_model.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/container_with_shadow_widget.dart';

class SingleRequestItem extends StatelessWidget {
  const SingleRequestItem({
    super.key,
    required this.request,
    required this.color,
  });

  final RequestModel request;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RequestCubit>.value(
      value: sl<RequestCubit>(),
      child: BlocBuilder<RequestCubit, RequestState>(
        buildWhen: (RequestState previous, RequestState current) =>
            sl<RequestCubit>().currentRequest == request.uuid,
        builder: (BuildContext context, RequestState state) {
          return ContainerWithShadow(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 16,
            ),
            margin: const EdgeInsets.only(top: 16, left: 20, right: 20),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(
                      height: 68,
                      width: 68,
                      child: MyImage.network(
                        url: request.senderImage,
                        height: 68,
                        width: 68,
                        borderRadius: 8,
                        color: AppColors.greenColor,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: AutoSizeText(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  minFontSize: 10,
                                  request.senderName == ""
                                      ? "test"
                                      : request.senderName!,
                                  style: smallStyle.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.blackColor,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: color.withOpacity(0.1),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 4),
                                child: Text(
                                  tr(
                                    request.status?.name ?? "",
                                  ),
                                  style: smallStyle.copyWith(
                                    color: color,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text.rich(TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: "${request.amount} ",
                                style: smallStyle.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: tr('sar'),
                                style: smallStyle.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          )),
                          Text.rich(TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: "${tr('created_at')} : ",
                                style: smallStyle.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              TextSpan(
                                text: request.credtedAt,
                                style: smallStyle.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ))
                        ],
                      ),
                    )
                  ],
                ),
                if (request.status ==
                    MoneyRequestFilterEnum.pending) ...<Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: LoadingButton(
                          onTap: () async {
                            await sl<RequestCubit>().acceptOrRejectRequest(
                                requestUUID: request.uuid!,
                                status: MoneyRequestFilterEnum.rejected);
                          },
                          loaderColor: AppColors.blackColor,
                          hasBottomSaveArea: false,
                          topPadding: 16,
                          height: 40,
                          borderColor: AppColors.borderColor,
                          backgroundColor: Colors.white,
                          title: tr(request.isSentByMe ? "cancel" : 'reject'),
                          fontColor: context.theme.primaryColor,
                          isLoading: state is RequestRejectLoadingState,
                        ),
                      ),
                      if (!request.isSentByMe) ...<Widget>[
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: LoadingButton(
                            hasBottomSaveArea: false,
                            onTap: () async {
                              ConfirmCancelDialog(
                                  context: context,
                                  title: tr('sure_send_money'),
                                  onConfirm: () async {
                                    await sl<RequestCubit>()
                                        .acceptOrRejectRequest(
                                            requestUUID: request.uuid!,
                                            status: MoneyRequestFilterEnum
                                                .accepted);
                                  });
                            },
                            height: 40,
                            topPadding: 16,
                            title: tr('confirm'),
                            isLoading: state is RequestAcceptanceLoadingState,
                          ),
                        )
                      ],
                    ],
                  )
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
