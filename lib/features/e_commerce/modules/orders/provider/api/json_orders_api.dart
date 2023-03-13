import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/api/base_orders_api.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/model/complain_order_inputs.dart';

class JsonOrdersApi extends BaseOrdersApi {
  @override
  Future<Either<Failure, Response<Map<String, dynamic>>>> getOrders() async {
    try {
      final String json = await rootBundle.loadString("assets/jsons/orders/orders_list.json");

      return right(Response<Map<String, dynamic>>(
        data: jsonDecode(json) as Map<String, dynamic>,
        statusCode: 200,
        requestOptions: RequestOptions(
          path: "",
        ),
      ));
    } catch (e) {
      return left(GeneralFailure(errors: <String,String>{'':e.toString()},));
    }
  }

  @override
  Future<Either<Failure, Response<Map<String, dynamic>>>> trackOrder(String uuid) {
    // TODO: implement trackOrder
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Response<Map<String, dynamic>>>> buyAgain(String uuid) {
    // TODO: implement buyAgain
    throw UnimplementedError();
  }

  @override
  Future<Option<Failure>> cancelOrder({String? description, required String orderUUID}) {
    // TODO: implement cancelOrder
    throw UnimplementedError();
  }

  @override
  Future<Option<Failure>> complainOrder(ComplainOrderInput inputs) {
    // TODO: implement complainOrder
    throw UnimplementedError();
  }
}
