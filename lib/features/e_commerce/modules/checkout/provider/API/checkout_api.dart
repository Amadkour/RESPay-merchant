import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/checkout/provider/API/end_point.dart';

class CheckoutAPI {
  late Dio _dio;

  /// ------------------------ Pass [Dio] To use it in testing ------------------------ ///
  CheckoutAPI({Dio? dio}) {
    _dio = dio ?? APIConnection.instance.dio;
  }

  /// --------------------------- SingleTone API ------------------------ ///
  CheckoutAPI._singleTone() {
    _dio = APIConnection.instance.dio;
  }

  static final CheckoutAPI _instance = CheckoutAPI._singleTone();

  static CheckoutAPI get instance => _instance;

  /// Forgot password API
  Future<Either<Failure, Response<Map<String, dynamic>>>> placeOrder({
    required String addressUUID,
    required String cartUUID,
    String? paymentMethod = 'wallet',
    String? walletUUID,
    String? creditCardUUID,
    String? bankAccountUUID,
  }) async {
    late Response<Map<String, dynamic>> response;

    try {
      final FormData formData = FormData.fromMap(<String, dynamic>{
        'address_uuid': addressUUID,
        'cart_uuid': cartUUID,
        'payment_method': paymentMethod,
        'wallet_uuid': walletUUID,
        'credit_card_uuid': creditCardUUID,
        'bank_account_uuid': bankAccountUUID,
      });

      /// Calling API
      response = await _dio.post(placeOrderPath, data: formData);

      /// Success (Successful Request)
      return Right<Failure, Response<Map<String, dynamic>>>(response);
    } catch (e) {
      /// Failed (API Crashed)
      return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure(
          code: response.statusCode,
          resourceName: 'placeOrder_api_line_52',
          errors: response.data!['errors'] as Map<String, dynamic>));
    }
  }
}
