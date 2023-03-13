// ignore_for_file: always_specify_types

import 'package:dio/dio.dart';
import 'package:res_pay_merchant/features/authentication/modules/pin_code/provider/api/end_point.dart';

import '../../core/abstract_values.dart';

///------success response

final successResponse = {
  "status_code": 200,
  "code": 1022,
  "hint": "Process successfully",
  "success": true,
  "data": {"message": "Pin Code created successfully!"}
};

//-------failure response
final failureResponse = {
  "success": false,
  "status_code": 422,
  "code": 1422,
  "hint": "Unprocessable Entity",
  "errors": {
    "user_uuid": ["The user uuid field is required."],
    "phone_number": ["The phone number field is required."],
    "email": ["The email field is required."],
    "identity_id": ["The identity id field is required."]
  }
};

final successBody = <String, dynamic>{
  'pin_code': "1234",
  'is_touch_active': 1,
  'is_face_active': 1,
};
final failureBody = <String, dynamic>{
  'pin_code': "1234",
  'is_face_active': 1,
};
final ValueClass pinCodeValues = ValueClass(
  path: pinPath,
  failureResponse: failureResponse,
  successfulResponse: successResponse,
  failureBody: FormData.fromMap(failureBody),
  successfulBody: FormData.fromMap(successBody),
);
