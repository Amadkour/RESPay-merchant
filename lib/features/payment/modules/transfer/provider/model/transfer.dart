import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';

class Transfer extends ParentModel{
  int? transferId;
  String? transferName;
  bool? supportNational;
  bool? supportLocal;

  Transfer({this.transferId, this.transferName, this.supportNational, this.supportLocal});

  @override
  Transfer fromJsonInstance(Map<String, dynamic> json) {
    final FromMap converter =FromMap(map: json);
    return Transfer(
      transferId:converter.convertToInt(key: "transferId",defaultValue: -1),
      transferName:converter.convertToString(key: "transferName",defaultValue: ""),
      supportNational:converter.convertToBool(key: "supportNational",defaultValue: false),
      supportLocal:converter.convertToBool(key: "supportLocal",defaultValue: false),

    );
  }
}
