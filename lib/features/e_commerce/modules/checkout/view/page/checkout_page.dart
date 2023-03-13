import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/dialogs/confitm_cancel_dialog.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/controller/hom_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/controller/cards_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/shipping_location/controller/shipping_location_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/controller/cart_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/view/componantes/summary_bottom_sheet_body.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/checkout/controller/checkout_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/checkout/view/component/bank_account/bank_account_method_widget.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/checkout/view/component/credit_card/credit_card_method_widget.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/checkout/view/component/delivery_location_widget.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/checkout/view/component/wallet/wallet_method_widget.dart';
import 'package:res_pay_merchant/features/payment/modules/history/controller/transaction_history_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/withdraw/controller/withdraw_cubit.dart';

import 'package:res_pay_merchant/routes/routes_name.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  /// TODO: Refactor
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<CardsCubit>.value(
          value: sl<CardsCubit>(),
        ),
        BlocProvider<ShippingLocationCubit>.value(
          value: sl<ShippingLocationCubit>(),
        ),
        BlocProvider<CartCubit>.value(
          value: sl<CartCubit>(),
        ),
        BlocProvider<HomCubit>.value(
          value: sl<HomCubit>(),
        ),
        BlocProvider<WithdrawCubit>.value(
          value: sl<WithdrawCubit>(),
        ),
        BlocProvider<TransactionHistoryCubit>.value(
          value: sl<TransactionHistoryCubit>(),
        ),
      ],
      child: BlocBuilder<WithdrawCubit, WithdrawState>(
        builder: (BuildContext context, WithdrawState withdrawState) {
          return BlocBuilder<TransactionHistoryCubit, TransactionHistoryState>(
            builder: (BuildContext context,
                TransactionHistoryState transactionHistoryState) {
              return BlocBuilder<CardsCubit, CardsState>(
                builder: (BuildContext context, CardsState cardsState) {
                  return BlocBuilder<ShippingLocationCubit,
                      ShippingLocationState>(
                    builder: (BuildContext context,
                        ShippingLocationState shippingLocationState) {
                      return BlocBuilder<CartCubit, CartState>(
                        builder: (BuildContext context, CartState cartState) {
                          return BlocBuilder<HomCubit, HomeState>(
                            builder:
                                (BuildContext context, HomeState homeState) {
                              if (shippingLocationState
                                      is ShippingLocationLoadLocation ||
                                  homeState is HomeLoading ||
                                  cardsState is CardsLoading ||
                                  cardsState is GetPaymentMethodsLoading ||
                                  withdrawState is WithdrawLoading ||
                                  transactionHistoryState is WalletLoading) {
                                return MainScaffold(
                                  appBarWidget:
                                      MainAppBar(title: tr('checkout')),
                                  scaffold: const Center(
                                    child: NativeLoading(),
                                  ),
                                );
                              } else {
                                return MainScaffold(
                                  appBarWidget:
                                      MainAppBar(title: tr('checkout')),
                                  bottomNavigationBar: context
                                          .read<CartCubit>()
                                          .cartModel!
                                          .cart!
                                          .items!
                                          .isNotEmpty
                                      ? BlocProvider<CheckoutCubit>.value(
                                          value: sl<CheckoutCubit>(),
                                          child: BlocBuilder<CheckoutCubit,
                                              CheckoutState>(
                                            builder: (BuildContext context,
                                                CheckoutState state) {
                                              return SummaryBody(
                                                buttonTitle: tr("proceed"),
                                                isLoadingButton: state
                                                    is CheckoutPlaceOrderLoad,
                                                enable: context
                                                    .watch<CheckoutCubit>()
                                                    .enableSummaryButton,
                                                onTapButton: () async {
                                                  ConfirmCancelDialog(
                                                      context: context,
                                                      title: tr(
                                                          'sure_place_order'),
                                                      onConfirm: () async {
                                                        final Map<String, dynamic> response = await context
                                                            .read<
                                                                CheckoutCubit>()
                                                            .placeOrder(

                                                                /// Get selected address from ShippingLocationCubit
                                                                addressUUID: context
                                                                    .read<
                                                                        ShippingLocationCubit>()
                                                                    .addresses[context
                                                                        .read<
                                                                            ShippingLocationCubit>()
                                                                        .selectedAddressIndex]
                                                                    .uuid!,

                                                                /// Get cart uuid from CartCubit
                                                                cartUUID: context
                                                                    .read<
                                                                        CartCubit>()
                                                                    .cartModel!
                                                                    .cart!
                                                                    .uuid!,

                                                                /// Get paymentMethodUUID from CheckoutCubit
                                                                walletUUID: context
                                                                    .read<
                                                                        TransactionHistoryCubit>()
                                                                    .wallet!
                                                                    .uuid);
                                                        MyToast(
                                                            response['message']
                                                                .toString());
                                                        if (response['success']
                                                            as bool) {
                                                          sl<TransactionHistoryCubit>()
                                                              .getWallet();
                                                          CustomNavigator
                                                              .instance
                                                              .popUntil((Route<
                                                                          dynamic>
                                                                      route) =>
                                                                  route.settings
                                                                      .name ==
                                                                  RoutesName
                                                                      .authDashboard);
                                                        }
                                                      });
                                                },
                                              );
                                            },
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                  scaffold: Container(
                                    padding: const EdgeInsets.all(20),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: <Widget>[
                                          const DeliveryLocationWidget(),
                                          const SizedBox(
                                            height: 20,
                                          ),

                                          WalletMethodWidget(
                                              totalCart: sl<CartCubit>()
                                                  .cartModel!
                                                  .cart!
                                                  .total!),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          if (context
                                              .watch<HomCubit>()
                                              .homeCards!
                                              .isNotEmpty)
                                            const CreditCardMethodWidget(),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          if (context
                                              .watch<WithdrawCubit>()
                                              .bankAccounts
                                              .isNotEmpty)
                                            const BankAccountMethodWidget(),
                                          const SizedBox(
                                            height: 20,
                                          ),

                                          // WalletMethodWidget(size: size)
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
