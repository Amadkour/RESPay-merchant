import 'package:dio/dio.dart';
import 'package:res_pay_merchant/features/authentication/modules/forget_password/provider/Api/end_point.dart';

import '../../../core/abstract_values.dart';

///------------ success Forget Password Inputs ----------------///

final Map<String, dynamic> successInput = <String, dynamic>{
  'identity_id': '20232023',
};

///------------ failure Forget Password Inputs ----------------///

final Map<String, dynamic> failureInput = <String, dynamic>{
  'identity_id': '20232021',
};

///------------- success Forget Password ----------------------///

Map<String, dynamic> forgetPasswordSuccessResponse = <String, dynamic>{
  "status_code": 200,
  "code": 1022,
  "hint": "Process successfully",
  "success": true,
  "data": <String, dynamic>{
    "otp": 7644,
    "message": "the otp sent successfully, please check your messages"
  }
};

///--------------- Failed Forget Password ---------------//////

Map<String, dynamic> forgetPasswordFailedResponse = <String, dynamic>{
  "success": false,
  "status_code": 422,
  "code": 1422,
  "hint": "Unprocessable Entity",
  "errors": <String, dynamic>{
    "identity_id": <String>["User not found!"]
  }
};

///--------------- Values ---------------//////
ValueClass forgetPasswordValues = ValueClass(
  successfulResponse: forgetPasswordSuccessResponse,
  failureResponse: forgetPasswordFailedResponse,
  successfulBody: FormData.fromMap(successInput),
  failureBody: FormData.fromMap(failureInput),
  path: forgotPasswordPath,
);
