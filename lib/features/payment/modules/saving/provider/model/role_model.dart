import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';

class RoleModel {
  String? uuid;
  String? walletUuid;
  String? userUuid;
  int? form;
  int? to;
  int? value;
  bool? isActive;
  String? type;
  String? createdAt;

  RoleModel(
      {this.uuid,
      this.walletUuid,
      this.userUuid,
      this.form,
      this.to,
      this.value,
      this.isActive,
      this.type,
      this.createdAt});

  RoleModel.fromJson(Map<String, dynamic> json) {
    final FromMap converter = FromMap(map: json);
    uuid = converter.convertToString(key: 'uuid');
    walletUuid = converter.convertToString(key: 'wallet_uuid');
    userUuid = converter.convertToString(key: 'user_uuid');
    type = converter.convertToString(key: 'type');
    createdAt = converter.convertToString(key: 'created_at');
    form = converter.convertToInt(key: 'form');
    to = converter.convertToInt(key: 'to');
    value = converter.convertToInt(key: 'value');
    isActive = converter.convertToBool(key: 'is_active');
  }
}
