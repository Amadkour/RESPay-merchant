import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/res/utils/parse_repo.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/provider/models/cart_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/api/base_orders_api.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/model/complain_order_inputs.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/model/order_list_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/model/order_model.dart';

class OrdersRepo {
  final BaseOrdersApi _api;

  OrdersRepo(this._api);

  Future<Either<Failure, ParentModel>> get() async {
    try {
      final Either<Failure, Response<Map<String, dynamic>>> response = await _api.getOrders();
      final ParentRepo<OrderListModel> parentRepo = ParentRepo<OrderListModel>(response, OrderListModel());
      return parentRepo.getRepoResponseAsFailureAndModel();
    } catch (e) {
      return left(GeneralFailure(
        errors: <String, String>{'': e.toString()},
      ));
    }
  }

  Future<Either<Failure, OrderModel>> trackOrder(String uuid) async {
    try {
      final Either<Failure, Response<Map<String, dynamic>>> response = await _api.trackOrder(uuid);

      return response.fold(
        (Failure l) => left(l),
        (Response<Map<String, dynamic>> r) => right(
          OrderModel.fromMap(
            (r.data!['data'] as Map<String, dynamic>)['order'] as Map<String, dynamic>,
          ),
        ),
      );
    } catch (e) {
      return left(GeneralFailure(errors: <String, dynamic>{"": e.toString()}));
    }
  }

  Future<Either<Failure, ParentModel>> buyAgain(String uuid) async {
    try {
      final Either<Failure, Response<Map<String, dynamic>>> response = await _api.buyAgain(uuid);

      return response.fold(
        (Failure l) => left(l),
        (Response<Map<String, dynamic>> r) {
          final ParentRepo<ParentModel> parentModel = ParentRepo<CartModel>(response, CartModel());
          return parentModel.getRepoResponseAsFailureAndModel();
        },
      );
    } catch (e) {
      return left(GeneralFailure(
        errors: <String, String>{'': e.toString()},
      ));
    }
  }

  Future<Option<Failure>> cancel({required String description, required String orderUUID}) async {
    try {
      return await _api.cancelOrder(
        description: description,
        orderUUID: orderUUID,
      );
    } catch (e) {
      return some(GeneralFailure(
        errors: <String, String>{'': e.toString()},
      ));
    }
  }

  Future<Option<Failure>> complain(ComplainOrderInput inputs) async {
    try {
      return await _api.complainOrder(inputs);
    } catch (e) {
      return some(GeneralFailure(
        errors: <String, String>{'': e.toString()},
      ));
    }
  }
}
