import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/configuration/top_level_configuration.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/custom_back_button.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/provider/model/logged_in_user_model.dart';
import 'package:res_pay_merchant/features/payment/modules/amount/controller/transaction_amount_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/controller/transfer_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/beneficary_model.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/checked_widget.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/container_with_shadow_widget.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/edit_button.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/transfer_sucess_dialog.dart';
import 'package:res_pay_merchant/features/payment/view/component/receipt/provider/model/receipt_model.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class NewTransferSummaryPage extends StatelessWidget {
  const NewTransferSummaryPage({super.key, required this.beneficiary});
  final Beneficiary beneficiary;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransferCubit>.value(
      value: sl<TransferCubit>(),
      child: Builder(builder: (BuildContext context) {
        final TransferCubit transferController = context.read<TransferCubit>();
        return MainScaffold(
          appBarWidget: AppBar(
            leading: const CustomBackButton(),
            title: Text(tr("new transfer")),
            centerTitle: false,
          ),
          scaffold: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  ContainerWithShadow(
                    margin: const EdgeInsets.only(top: 22, bottom: 24),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              tr("amount"),
                              style: paragraphStyle,
                            ),
                            const CheckWidget(
                              isChecked: true,
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 16),
                          child: Divider(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            BlocProvider<TransactionAmountCubit>.value(
                              value: sl<TransactionAmountCubit>(),
                              child: Builder(builder: (BuildContext context) {
                                final TransactionAmountCubit amountCubit =
                                    context.read<TransactionAmountCubit>();
                                return Text(
                                  "${amountCubit.amount} ${amountCubit.currentCurrency?.iso3Code}",
                                  style: headlineStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }),
                            ),
                            EditButton(
                              onPressed: () {
                                CustomNavigator.instance.pop();
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  ContainerWithShadow(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 25),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              tr("from"),
                              style: paragraphStyle,
                            ),
                            const CheckWidget(
                              isChecked: true,
                            )
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 16),
                          child: Divider(),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            "Res App",
                            style: smallStyle.copyWith(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          subtitle: Text(
                            loggedInUser.uuid ?? "",
                            style: smallStyle.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              EditButton(
                                onPressed: () {},
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                tr("to"),
                                style: paragraphStyle,
                              ),
                              const CheckWidget(
                                isChecked: true,
                              )
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 16),
                          child: Divider(),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            beneficiary.firstName ?? "",
                            style: smallStyle.copyWith(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          subtitle: Text(
                            beneficiary.accountNumber ??
                                beneficiary.phoneNumber ??
                                "",
                            style: smallStyle.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              EditButton(
                                onPressed: () {
                                  CustomNavigator.instance.pop();
                                },
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                tr("details"),
                                style: paragraphStyle,
                              ),
                              const CheckWidget(
                                isChecked: true,
                              )
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 16),
                          child: Divider(),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            tr("purpose"),
                            style: smallStyle.copyWith(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          subtitle: Text(
                            transferController.purpose ?? "",
                            style: smallStyle.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              EditButton(
                                onPressed: () {
                                  CustomNavigator.instance.pop();
                                },
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                tr("fees"),
                                style: paragraphStyle,
                              ),
                              const CheckWidget(
                                isChecked: true,
                              )
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 16),
                          child: Divider(),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            tr("transaction fees"),
                            style: smallStyle.copyWith(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          subtitle: Text(
                            "10.000 SAR",
                            style: smallStyle.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            tr("amount_in_account_currency"),
                            style: smallStyle.copyWith(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          subtitle: Text(
                            "500.00 SAR",
                            style: smallStyle.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            tr("amount_in_beneficiary_currency"),
                            style: smallStyle.copyWith(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          subtitle: Text(
                            "10.000 EGP",
                            style: smallStyle.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            tr("exchange_rate"),
                            style: smallStyle.copyWith(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          subtitle: Text(
                            "1 EGP = 0.1537 SAR",
                            style: smallStyle.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 13, bottom: 32),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      color: AppColors.pointButtonColor.withOpacity(0.1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          MyImage.svgAssets(
                            url: "assets/icons/transfer/megaphone.svg",
                            width: 16,
                            height: 16,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "${tr("you_will_get")} 1000 ${tr('points')}",
                            style: smallStyle.copyWith(
                              color: AppColors.greenColor,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Text.rich(
                    TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: tr("by_click_confirm_you_agree"),
                          style: smallStyle.copyWith(
                            fontWeight: FontWeight.normal,
                          )),
                      TextSpan(
                          text: " ${tr("terms_and_conditions")}",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              CustomNavigator.instance
                                  .pushNamed(RoutesName.terms);
                            },
                          style: smallStyle.copyWith(
                            color: AppColors.blueColor,
                            fontWeight: FontWeight.w500,
                          ))
                    ]),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: LoadingButton(
                        isLoading: false,
                        title: tr('confirm'),
                        onTap: () {
                          CustomNavigator.instance.pushNamed(
                              verificationMethodPath, arguments: () async {
                            final ReceiptModel? result =
                                await transferController
                                    .createTransfer(beneficiary.uuid!);
                            CustomNavigator.instance.maybePop();
                            if (result != null) {
                              TransferSuccessDialog.instance.show(
                                context,
                                receiptModel: result.copyWith(
                                  beneficiary: beneficiary,
                                ),
                              );
                            }
                          });
                        },
                      ))
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
