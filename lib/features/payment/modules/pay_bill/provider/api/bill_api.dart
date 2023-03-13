import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';
import 'package:res_pay_merchant/features/payment/modules/pay_bill/provider/api/end_points.dart';

class BillApi {
  APIConnection apiConnection = APIConnection.instance;

  BillApi({APIConnection? apiConnect}) {
    if (apiConnect != null) {
      apiConnection = apiConnect;
    } else {
      apiConnection = APIConnection.instance;
    }
  }

  BillApi._singleTone();

  static final BillApi _instance = BillApi._singleTone();

  static BillApi get instance => _instance;

  ///----------------Get Supplies List
  Future<Either<Failure, Response<Map<String, dynamic>>>>
      getSuppliesList() async {
    // apiConnection.dio.options.baseUrl =
    //     'https://wallet.eightyythree.com/api/wallet';

    apiConnection.showMessage = true;
    Response<Map<String, dynamic>>? response;
    try {
      response = await apiConnection.dio.get(
        suppliesPath,
      );
      return Right<Failure, Response<Map<String, dynamic>>>(response);
    } catch (e) {
      if (response != null) {
        return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure(
            code: response.statusCode,
            resourceName: 'Bill_api_line_90',
            errors: response.data!['errors'] as Map<String, dynamic>));
      } else {
        return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure());
      }
    }
  }

  ///----------------Bill Request

  Future<Either<Failure, Response<Map<String, dynamic>>>> payBill({
    String? supplierType,
    String? customerId,
    int check = 0,
  }) async {
    apiConnection.showMessage = true;
    late Response<Map<String, dynamic>> response;

    try {
      response = await apiConnection.dio.post(billPath, data: <String, dynamic>{
        'supplier': supplierType,
        'customer_id': customerId,
        'check': check
      });

      return Right<Failure, Response<Map<String, dynamic>>>(response);
    } catch (e) {
      return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure(
          code: response.statusCode,
          resourceName: 'pay_bill_api_line_72',
          errors: response.data!['errors'] as Map<String, dynamic>));
    }
  }
}
