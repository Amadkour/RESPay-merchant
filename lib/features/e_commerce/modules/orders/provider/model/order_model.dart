import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/shipping_location/provider/model/address_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/model/order_item_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/model/tracking_stage_model.dart';

class OrderModel {
  final String orderNumber;
  final String uuid;
  final String addressUuid;
  final String paymentMethodUuid;
  final List<OrderItemModel> products;
  final double subTotal;
  final double taxes;
  final double shipping;
  final double discount;
  final double total;
  String? status;
  final List<TrackingStageModel> timeline;
  final DateTime? estimateDeliveryDate;
  final bool isComplete;
  final AddressModel? address;
  OrderModel({
    required this.uuid,
    required this.addressUuid,
    required this.paymentMethodUuid,
    required this.products,
    required this.subTotal,
    required this.taxes,
    required this.shipping,
    required this.discount,
    required this.total,
    required this.orderNumber,
    this.status,
    this.timeline = const <TrackingStageModel>[],
    this.estimateDeliveryDate,
    this.isComplete = false,
    this.address,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    final FromMap converter = FromMap(map: map);
    return OrderModel(
      orderNumber: converter.convertToString(key: "order_number") ?? "",
      uuid: converter.convertToString(key: "uuid") ?? "",
      addressUuid: converter.convertToString(key: "address_uuid") ?? "",
      paymentMethodUuid: converter.convertToString(key: "payment_method_uuid") ?? "",
      products: List<OrderItemModel>.from(
        (map['items'] as List<dynamic>).map(
          (dynamic map) => OrderItemModel.fromJson(map as Map<String, dynamic>),
        ),
      ),
      subTotal: converter.convertToDouble(key: "sub_total") ?? 0,
      taxes: converter.convertToDouble(key: "tax") ?? 0,
      shipping: converter.convertToDouble(key: "shipping") ?? 0,
      discount: converter.convertToDouble(key: 'discount') ?? 0,
      total: converter.convertToDouble(key: 'total') ?? 0,
      status: map['status']?.toString(),
      timeline: List<TrackingStageModel>.from(
        (map['timeline'] as List<dynamic>?)
                ?.map((dynamic map) => TrackingStageModel.fromMap(map as Map<String, dynamic>)) ??
            <TrackingStageModel>[],
      ),
      estimateDeliveryDate: map['estimated'] != null ? DateTime.parse(map['estimated']! as String) : null,
      isComplete: map['is_complete'] as bool? ?? false,
      address: map['address'] != null ? AddressModel().fromJsonInstance(map['address'] as Map<String, dynamic>) : null,
    );
  }
}
