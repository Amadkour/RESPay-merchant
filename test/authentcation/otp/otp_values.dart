// ignore_for_file: always_specify_types

import 'package:dio/dio.dart';
import 'package:res_pay_merchant/features/authentication/modules/otp/provider/api/end_point.dart';

import '../../core/abstract_values.dart';

///---> successful body
final Map<String, String> successfulBody = <String, String>{
  "phone_number": "0566499165",
  "otp": "1234",
};

///------> failure body
final Map<String, String> failureBody = <String, String>{
  "otp": "1234",
};

///---> failure response
final Map<String, dynamic> failureResponse = <String, dynamic>{
  "status_code": 422,
  "code": 1422,
  "hint": "Unprocessable Entity",
  "errors": {
    "phone_number": ["The selected phone number is invalid."]
  },
  "success": false
};

//--------> successful response

final successfulResponse = {
  "status_code": 200,
  "code": 1022,
  "hint": "Process successfully",
  "success": true,
  "message": "the otp sent successfully, please check your messages",
  "data": {
    "otp": 7732,
    "message": "the otp sent successfully, please check your messages",
  }
};

final ValueClass otpValues = ValueClass(
  path: otpPath,
  successfulBody: FormData.fromMap(successfulBody),
  failureResponse: failureResponse,
  successfulResponse: successfulResponse,
  failureBody: FormData.fromMap(failureBody),
);
