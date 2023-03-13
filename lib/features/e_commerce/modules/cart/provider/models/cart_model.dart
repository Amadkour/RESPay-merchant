import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';

class CartModel extends ParentModel{

  String? message;
  Cart? cart;

  CartModel({this.message, this.cart});

  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    final FromMap converter = FromMap(map: json);
    return CartModel(
      message: json['error']==null?converter.convertToString(key: "message"):converter.convertToString(key: "error"),
      cart: json['cart']!=null&&json['cart'] is Map<String,dynamic>? Cart().fromJson(json['cart'] as Map<String,dynamic>) : Cart(
        items: <CartItemModel>[],
      )
    );
  }
}

class Cart{
  int? id;
  String? uuid;
  String? userUuid;
  double? discount;
  double? shipping;
  String? shopSlug;
  double? subTotal;
  double? tax;
  double? total;
  List<CartItemModel>? items;

  Cart(
      {this.id,
        this.uuid,
        this.userUuid,
        this.discount,
        this.shipping,
        this.subTotal,
        this.shopSlug,
        this.tax,
        this.total,
        this.items});

  Cart fromJson(Map<String, dynamic> json) {
    final FromMap converter = FromMap(map: json);
    return Cart(
        id: converter.convertToInt(key: "id"),
        uuid: converter.convertToString(key: "uuid"),
        userUuid: converter.convertToString(key: "user_uuid"),
        discount: converter.convertToDouble(key: "discount"),
        shipping: converter.convertToDouble(key: "shipping"),
        subTotal: converter.convertToDouble(key: "sub_total"),
        shopSlug: converter.convertToString(key: "shop_uuid"),
        tax: converter.convertToDouble(key: "tax"),
        total: converter.convertToDouble(key: "total"),
        items: converter.convertToListOFModel(jsonData: json['items'],modelInstance: CartItemModel())
    );
  }
}

class CartItemModel extends ParentModel{
  String? productUuid;
  String? uuid;
  String? title;
  double? price;
  String? thumbImage;
  List<void>? variants;
  String? quantity;

  CartItemModel(
      {this.productUuid,
        this.title,
        this.uuid,
        this.price,
        this.thumbImage,
        this.variants,
        this.quantity});

  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    final FromMap converter = FromMap(map: json);
    return CartItemModel(
        productUuid: converter.convertToString(key: "product_uuid"),
        title: converter.convertToString(key: "title"),
        uuid: converter.convertToString(key: "uuid"),
        price: converter.convertToDouble(key: "price"),
        thumbImage: converter.convertToString(key: "thumb_image"),
        quantity: converter.convertToString(key: "quantity"),
    );
  }
}
