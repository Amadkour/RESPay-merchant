import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';

class OrderItemModel {
  final String productUUid;
  final String uuid;
  final String title;
  final double price;
  final String thumbImage;
  final int quantity;
  OrderItemModel({
    required this.productUUid,
    required this.uuid,
    required this.title,
    required this.price,
    required this.thumbImage,
    required this.quantity,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> map) {
    final FromMap fromMap = FromMap(map: map);
    return OrderItemModel(
      productUUid: fromMap.convertToString(key: "product_uuid") ?? "",
      uuid: fromMap.convertToString(key: "uuid") ?? "",
      title: fromMap.convertToString(key: "title") ?? "",
      price: fromMap.convertToDouble(key: "price") ?? 0,
      thumbImage: fromMap.convertToString(key: "thumb_image") ?? "",
      quantity: fromMap.convertToInt(key: "quantity") ?? 0,
    );
  }
}
