import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/model/order_model.dart';

class OrderListModel extends ParentModel {
  final List<OrderModel> orders;
  final List<String> status;
  OrderListModel({
    this.orders = const <OrderModel>[],
    this.status = const <String>[],
  });

  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    final List<OrderModel> history = List<OrderModel>.from(
        (json['orders'] as List<dynamic>).map((dynamic map) => OrderModel.fromMap(map as Map<String, dynamic>)));
    final List<String> statusList = List<String>.from(json['status'] as List<dynamic>);
    return OrderListModel(
      orders: history,
      status: statusList,
    );
  }
}
