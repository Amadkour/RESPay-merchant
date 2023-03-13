// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dio/dio.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/provider/model/logged_in_user_model.dart';


class ComplainOrderInput {
  final String orderUUID;
  final String reasonType;
  final String description;
  final List<String> images;
  ComplainOrderInput({
    required this.orderUUID,
    required this.reasonType,
    required this.description,
    required this.images,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'order_uuid': orderUUID,
      'reason_type': reasonType,
      'description': description,
      'images[]': images.map((String e) => MultipartFile.fromFileSync(e)).toList(),
      "user_uuid": loggedInUser.uuid,
    };
  }
}
