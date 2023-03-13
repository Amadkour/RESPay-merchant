import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/checkout/provider/API/checkout_api.dart';

class CheckoutRepository {
  late CheckoutAPI _checkoutAPI;

  /// ------------------------ Pass [CheckoutAPI] To use it in testing ------------------------ ///
  CheckoutRepository({CheckoutAPI? checkoutAPI}) {
    _checkoutAPI = checkoutAPI ?? CheckoutAPI.instance;
  }

  /// --------------------------- SingleTone Repository ------------------------ ///
  CheckoutRepository._singleTone() {
    _checkoutAPI = CheckoutAPI.instance;
  }

  static final CheckoutRepository _instance = CheckoutRepository._singleTone();

  static CheckoutRepository get instance => _instance;

  Future<Either<Failure, Map<String, dynamic>>> placeOrderRepository({
    required String addressUUID,
    required String cartUUID,
    String? paymentMethod = 'wallet',
    String? walletUUID,
    String? creditCardUUID,
    String? bankAccountUUID,
  }) async {
    try {
      /// --------------------------- Calling API Function ------------------------ ///
      final Either<Failure, Response<dynamic>> res =
          await _checkoutAPI.placeOrder(
              addressUUID: addressUUID,
              cartUUID: cartUUID,
              walletUUID: walletUUID,
              paymentMethod: paymentMethod,
              creditCardUUID: creditCardUUID,
              bankAccountUUID: bankAccountUUID);

      return res.fold((Failure l) => Left<Failure, Map<String, dynamic>>(l),
          (Response<dynamic> response) {
        if (response.statusCode != 200 ||
            !((response.data as Map<String, dynamic>?)!['success'] as bool)) {
          /// Failure Response
          return Left<Failure, Map<String, dynamic>>(ApiFailure(

              code: response.statusCode,
              resourceName: 'checkoutRepository_line_43',
              errors: ((response.data as Map<String, dynamic>?)!['errors']
                      as Map<String, dynamic>?) ??
                  <String, String>{}));
        } else {
          /// Success
          return Right<Failure, Map<String, dynamic>>(
              response.data! as Map<String, dynamic>);
        }
      });
    } on Exception catch (e) {
      /// Repository Crashed
      return Left<Failure, Map<String, dynamic>>(ApiFailure(
        errors: <String,String>{'':e.toString()},
        code: 404,
        resourceName: 'checkoutRepository_line_58',
      ));
    }
  }
}
