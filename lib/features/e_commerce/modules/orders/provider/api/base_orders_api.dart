import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/model/complain_order_inputs.dart';

abstract class BaseOrdersApi {
  Future<Either<Failure, Response<Map<String, dynamic>>>> getOrders();
  Future<Either<Failure, Response<Map<String, dynamic>>>> trackOrder(String uuid);
  Future<Either<Failure, Response<Map<String, dynamic>>>> buyAgain(String uuid);
  Future<Option<Failure>> cancelOrder({required String description, required String orderUUID});
  Future<Option<Failure>> complainOrder(ComplainOrderInput inputs);
}
