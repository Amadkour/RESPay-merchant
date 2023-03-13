import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';

class SendGiftModel extends ParentModel{
  String? message;
  double? amount;
  List<String>? from;
  List<String>? to;
  String? type;
  String? date;

  SendGiftModel(
      {this.message, this.amount, this.from, this.to, this.type, this.date});

  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    final FromMap converter =FromMap(map: json);
    return SendGiftModel(
      message: converter.convertToString(key: "message",defaultValue: ""),
      amount: converter.convertToDouble(key: "amount",defaultValue: 0),
      from: converter.convertToListOFString(json['from']),
      to: converter.convertToListOFString(json['to']),
      type: converter.convertToString(key: "type",defaultValue: ""),
      date: converter.convertToString(key: "date",defaultValue: ""),
    );
  }
}
