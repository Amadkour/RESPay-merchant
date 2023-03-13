// ignore_for_file: always_specify_types

import 'package:dio/dio.dart';
import 'package:res_pay_merchant/features/payment/modules/request/provider/api/end_points.dart';

import '../core/abstract_values.dart';

///------------ success sendMoney Inputs ----------------///

final Map<String, dynamic> sendMoneySuccessInput = <String, dynamic>{
  "amount": "100",
  "beneficiary_uuid": "345345345-345345-345324d",
  "category": "32423432432432",
  "note": "test",
};

///------------ failure sendMoney Inputs ----------------///

final Map<String, dynamic> sendMoneyFailureInput = <String, dynamic>{
  "amount": "",
  "beneficiary_uuid": "345345345-345345-345324d",
  "category": "32423432432432",
  "note": "test",
};

///------------- success sendMoney ----------------------///

Map<String, dynamic> sendMoneySuccessResponse = {
  "status_code": 200,
  "code": 1020,
  "hint": "Processed successfully",
  "success": true,
  "data": {
    "message": "تم ارسال الطلب بنجاح",
    "request": {
      "uuid": "637b0ea7-031f-4225-a1ab-6f581504ae46",
      "sender": "5d4014d7-932d-448c-a9b3-bcedffc66e7f",
      "receiver": "24667083-0df3-4982-9d2c-28d49c9c235c",
      "amount": 100,
      "status": "pending",
      "credted_at": "2023-03-02T11:52:34.000000Z"
    }
  }
};

///--------------- Failed sendMoney ---------------//////

Map<String, dynamic> sendMoneyFailedResponseWithUserNotFound = <String, dynamic>{
  "status_code": 404,
  "code": 1044,
  "hint": "Resource not found",
  "success": false,
  "errors": <String, dynamic>{"error": "User not found!"}
};

///--------------- Values ---------------//////
ValueClass sendMoneyValues = ValueClass(
  successfulResponse: sendMoneySuccessResponse,
  failureResponse: sendMoneyFailedResponseWithUserNotFound,
  successfulBody: FormData.fromMap(sendMoneySuccessInput),
  failureBody: FormData.fromMap(sendMoneyFailureInput),
  path: moneyRequest,
);
