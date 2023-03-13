import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/constants.dart';

class Beneficiary extends ParentModel {
  String? userUUID;
  String? uuid;
  String? type;
  ServiceType? method;
  String? methodType;
  int? countryId;
  int? currencyId;
  String? firstName;
  String? lastName;
  String? relation;
  String? imageUrl;
  bool? isActive;
  bool? isFavorite;
  String? phoneNumber;
  String? bankName;
  String? accountNumber;
  String? iban;
  String? swiftCode;
  int? nationalityId;
  String? walletName;
  String? createdAt;
  String get fullName => "$firstName $lastName";
  Beneficiary(
      {this.userUUID,
      this.imageUrl,
      this.walletName,
      this.nationalityId,
      this.uuid,
      this.methodType,
      this.type,
      this.method,
      this.countryId,
      this.currencyId,
      this.firstName,
      this.lastName,
      this.relation,
      this.isActive,
      this.isFavorite,
      this.phoneNumber,
      this.bankName,
      this.accountNumber,
      this.iban,
      this.swiftCode,
      this.createdAt});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (type != null) data['type'] = type;
    if (methodType != null) data['method'] = methodType;
    if (countryId != null) data['country'] = countryId;
    if (currencyId != null) data['currency'] = currencyId;
    if (firstName != null) data['first_name'] = firstName;
    if (lastName != null) data['last_name'] = lastName;
    if (relation != null) data['relationship'] = relation;
    if (phoneNumber != null) data['phone_number'] = phoneNumber;
    if (bankName != null) data['bank_name'] = bankName;
    if (accountNumber != null) data['account_number'] = accountNumber;
    if (iban != null) data['iban'] = iban;
    if (nationalityId != null) data['nationality'] = nationalityId;
    if (swiftCode != null) data['swift_code'] = swiftCode;
    if (walletName != null) data['wallet_name'] = walletName;
    return data;
  }
  ServiceType getCorrectServiceType(String? name){
    switch(name!.replaceAll("_", "").toLowerCase()){
      case  "request money" :
        return ServiceType.request_money;

      case  "gift" :
        return ServiceType.gift;
      default :
        return ServiceType.transfer;
    }
  }
  @override
  Beneficiary fromJsonInstance(Map<String, dynamic> json) {
    final FromMap converter = FromMap(map: json);
    final String? methodType = converter.convertToString(key: "method", defaultValue: "");

    return Beneficiary(
      uuid: converter.convertToString(key: "uuid", defaultValue: ""),
      imageUrl: converter.convertToString(key: "imageUrl"),
      type: converter.convertToString(key: "type", defaultValue: ""),
      countryId: converter.convertToInt(key: "country_id", defaultValue: -1),
      currencyId: converter.convertToInt(key: "currency_id", defaultValue: -1),
      firstName: converter.convertToString(key: "first_name", defaultValue: ""),
      lastName: converter.convertToString(key: "last_name", defaultValue: ""),
      relation: converter.convertToString(key: "relation", defaultValue: ""),
      isActive: converter.convertToBool(key: "is_active", defaultValue: false),
      method: getCorrectServiceType(methodType),
      methodType: methodType,
      isFavorite: converter.convertToBool(key: "is_favorite", defaultValue: false),
      phoneNumber: converter.convertToString(key: "phone_number", defaultValue: ""),
      bankName: converter.convertToString(key: "bank_name", defaultValue: ""),
      accountNumber: converter.convertToString(key: "account_number"),
      iban: converter.convertToString(key: "iban", defaultValue: ""),
      swiftCode: converter.convertToString(key: "swift_code", defaultValue: ""),
      createdAt: converter.convertToString(key: "created_at", defaultValue: ""),
    );
  }
}

class BeneficiariesModel extends ParentModel {
  List<Beneficiary>? beneficiaries;
  List<String>? relations;
  BeneficiariesModel({this.beneficiaries, this.relations});

  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    final FromMap converter = FromMap(map: json);
    return BeneficiariesModel(
        beneficiaries: converter.convertToListOFModel(jsonData: json['beneficiaries'], modelInstance: Beneficiary()),
        relations: converter.convertToListOFString(json['relations']));
  }
}
