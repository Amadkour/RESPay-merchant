import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/provider/model/logged_in_user_model.dart';
import 'package:res_pay_merchant/features/payment/modules/request/provider/model/money_request_filter_enum.dart';

class MoneyRequestsModel extends ParentModel {
  List<String>? categories;

  List<RequestModel>? requests;

  MoneyRequestsModel({this.categories, this.requests});

  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    final FromMap converter = FromMap(map: json);
    return MoneyRequestsModel(
        requests: converter.convertToListOFModel(
            jsonData: json["money_requests"], modelInstance: RequestModel()),
        categories: converter.convertToListOFString(json['categories']));
  }
}

class RequestModel extends ParentModel {
  String? uuid;
  String? sender;
  String? senderName;
  String? senderImage;
  String? receiver;
  double? amount;
  MoneyRequestFilterEnum? status;
  String? credtedAt;

  bool get isSentByMe => sender == loggedInUser.uuid;

  RequestModel(
      {this.uuid,
      this.sender,
      this.receiver,
      this.amount,
      this.senderName,
      this.status,
      this.senderImage,
      this.credtedAt});

  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    final FromMap converter = FromMap(map: json);
    final DateTime createdAt =
        DateTime.parse(converter.convertToString(key: "credted_at")!);
    return RequestModel(
      uuid: converter.convertToString(key: "uuid"),
      sender: converter.convertToString(key: "sender_uuid"),
      receiver: converter.convertToString(key: "receiver"),
      amount: converter.convertToDouble(key: "amount"),
      status: MoneyRequestFilterEnum.values.firstWhere(
          (MoneyRequestFilterEnum element) =>
              element.name.toLowerCase() ==
              converter.convertToString(key: "status")),
      credtedAt: "${createdAt.day} - ${createdAt.month} - ${createdAt.year}",
      senderName:
          converter.convertToString(key: "sender_name", defaultValue: ""),
      senderImage: converter.convertToString(key: "sender_image"),
    );
  }
}
