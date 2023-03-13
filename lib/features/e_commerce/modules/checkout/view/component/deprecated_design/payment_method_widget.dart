// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
// import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
// import 'package:res_pay_merchant/features/e_commerce/modules/checkout/controller/checkout_cubit.dart';
// import 'package:res_pay_merchant/features/e_commerce/modules/checkout/view/component/checkout_widget.dart';
// import 'package:res_pay_merchant/features/e_commerce/modules/checkout/view/component/payment_method_bottom_sheet.dart';
// import 'package:res_pay_merchant/features/history/controller/transaction_history_cubit.dart';
//
// class PaymentMethodWidget extends StatelessWidget {
//   const PaymentMethodWidget({super.key, required this.size});
//
//   final Size size;
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<CheckoutCubit>.value(
//       value: sl<CheckoutCubit>(),
//       child: BlocBuilder<CheckoutCubit, CheckoutState>(
//         builder: (BuildContext context, CheckoutState state) {
//           return CheckoutWidget(
//             blackTextTitle: tr('payment_method'),
//             blueTextTitle: tr('change'),
//             onTapBlueText: () {
//               showPaymentMethodBottomSheet(context: context, size: size);
//             },
//             size: size,
//             imageUrl: 'assets/icons/e_commerce/new_card.svg',
//             imageHeight: size.width * 0.06,
//             imageWidth: size.width * 0.06,
//             title: AutoSizeText(
//               '${context.watch<CheckoutCubit>().selectedPaymentMethod!.name!} '
//                   '${context.watch<CheckoutCubit>().selectedPaymentMethod!.name!
//                   .toLowerCase() == 'wallet'
//                   ? '  (${sl<TransactionHistoryCubit>().wallet == null ?
//               "" : sl<TransactionHistoryCubit>().wallet!.total} SAR )' : ''}',
//               style: Theme.of(context)
//                   .textTheme
//                   .subtitle1!
//                   .copyWith(fontWeight: FontWeight.w500, fontSize: 14),
//             ),
//
//             /// Cart number
//             // subTitle: Row(
//             //   children: <Widget>[
//             //     ...List<Widget>.generate(
//             //         12,
//             //         (int index) => Row(
//             //               children: <Widget>[
//             //                 Container(
//             //                   height: 5,
//             //                   width: 5,
//             //                   decoration: BoxDecoration(
//             //                       color: AppColors.blackColor,
//             //                       shape: BoxShape.circle),
//             //                 ),
//             //                 Builder(builder: (_) {
//             //                   if ((index + 1) % 4 == 0) {
//             //                     return const SizedBox(
//             //                       width: 12,
//             //                     );
//             //                   } else {
//             //                     return const SizedBox(
//             //                       width: 4,
//             //                     );
//             //                   }
//             //                 }),
//             //               ],
//             //             )),
//             //     AutoSizeText(
//             //       context
//             //           .watch<HomCubit>()
//             //           .homeCards![
//             //               context.watch<HomCubit>().selectedCardCheckout]
//             //           .cardNumber!
//             //           .substring(12, 16),
//             //       style: Theme.of(context).textTheme.subtitle1!.copyWith(
//             //           color: AppColors.blackColor,
//             //           fontSize: 14,
//             //           fontWeight: FontWeight.w500),
//             //     ),
//             //   ],
//             // ),
//           );
//         },
//       ),
//     );
//   }
// }
