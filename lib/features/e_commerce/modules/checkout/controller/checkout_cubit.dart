import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/shipping_location/controller/shipping_location_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/controller/cart_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/provider/models/cart_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/checkout/provider/repository/checkout_repository.dart';

import 'package:res_pay_merchant/features/payment/modules/history/controller/transaction_history_cubit.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  // void changeSelectedMethodUUID(PaymentMethod paymentMethod) {
  //   selectedPaymentMethod = paymentMethod;
  //   emit(CheckoutChangePaymentMethod());
  // }

  int selectedCardCheckout = 0;
  int selectedBankAccountCheckout = 0;

  bool get enableSummaryButton {
    return sl<TransactionHistoryCubit>().wallet != null &&
        sl<TransactionHistoryCubit>().wallet!.total! >
            sl<CartCubit>().cartModel!.cart!.total! &&
        sl<ShippingLocationCubit>().addresses.isNotEmpty;
  }

  void toggleCard(int? cardValue) {
    selectedCardCheckout = cardValue!;
    emit(CheckoutChangeToggleCards());
  }

  void toggleBankAccount(int? bankAccount) {
    selectedCardCheckout = bankAccount!;
    emit(CheckoutChangeToggleCards());
  }

  Future<Map<String, dynamic>> placeOrder({
    required String addressUUID,
    required String cartUUID,
    String? paymentMethod = 'wallet',
    String? walletUUID,
    String? creditCardUUID,
    String? bankAccountUUID,
  }) async {
    emit(CheckoutPlaceOrderLoad());
    final Map<String, dynamic> map = <String, dynamic>{};
    try {
      /// Call API
      (await CheckoutRepository.instance.placeOrderRepository(
              addressUUID: addressUUID,
              cartUUID: cartUUID,
              paymentMethod: paymentMethod,
              walletUUID: walletUUID))

          /// Failure checkout
          .fold((Failure l) {
        map.addEntries(<MapEntry<String, dynamic>>[
          MapEntry<String, dynamic>("message", l.message),
          const MapEntry<String, dynamic>("success", false)
        ]);
      },

              /// Success checkout
              (Map<String, dynamic> r) {
        /// delete Cart items
        sl<CartCubit>().cartModel!.cart!.items = <CartItemModel>[];

        map.addEntries(<MapEntry<String, dynamic>>[
          MapEntry<String, dynamic>("message", tr('order_placed_success')),
          const MapEntry<String, dynamic>("success", true)
        ]);
      });
    } catch (e) {
      /// Catch
      emit(CheckoutFailure());
      return <String, dynamic>{
        "message": tr('something_went_wrong'),
        "success": false
      };
    } finally {
      emit(CheckoutPlaceOrderLoaded());
    }

    return map;
  }
}
