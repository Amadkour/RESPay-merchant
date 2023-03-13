import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';

class CreditCardModel {
  int? id;
  String? uuid;
  String? holderName;
  String? cardNumber;
  String? expiryDate;
  int? cvv;
  String? type;
  bool? isActive;

  CreditCardModel({
    this.id,
    this.holderName,
    this.cardNumber,
    this.expiryDate,
    this.cvv,
    this.type,
    this.isActive,
    this.uuid,
  });

  CreditCardModel.fromJson(Map<String, dynamic> json) {
    final FromMap converter = FromMap(map: json);
    holderName = converter.convertToString(key: 'holder_name');
    id = converter.convertToInt(key: 'id');
    cardNumber = converter.convertToString(key: 'card_number');
    expiryDate = converter.convertToString(key: 'expiry_date');
    type = converter.convertToString(key: 'type');
    uuid = converter.convertToString(key: 'uuid');
    isActive = converter.convertToBool(key: 'is_active');
    cvv = converter.convertToInt(key: 'cvv');
  }
}
