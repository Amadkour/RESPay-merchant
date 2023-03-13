import 'package:dio/dio.dart';
import 'package:res_pay_merchant/features/authentication/modules/forget_password/provider/Api/end_point.dart';

import '../../../core/abstract_values.dart';

///------------ success Create New Password Inputs ----------------///

final Map<String, dynamic> successInput = <String, dynamic>{
  'identity_id': '20232023',
  'password_confirmation': 'Mobile@2022',
  'password': 'Mobile@2022',
};

///------------ failure Create New Password Inputs ----------------///

final Map<String, dynamic> failureInput = <String, dynamic>{
  'identity_id': '20232022',
  'password_confirmation': 'Mobile@2022',
  'password': 'Mobile@2022',
};

///------------- success Forget Password ----------------------///

Map<String, dynamic> createNewPasswordSuccessResponse = <String, dynamic>{
  "status_code": 200,
  "code": 1022,
  "hint": "Process successfully",
  "success": true,
  "data": <String, String>{"message": "Your password changed successfully"}
};

///--------------- Failed Forget Password ---------------//////

Map<String, dynamic> createNewPasswordFailedResponse = <String, dynamic>{
  "success": false,
  "status_code": 422,
  "code": 1422,
  "hint": "Unprocessable Entity",
  "errors": <String, dynamic>{
    "identity_id": <String>[
      "User not found!",
      "User Account Not Verified, verify your account first!"
    ]
  }
};

///--------------- Values ---------------//////
ValueClass createNewPasswordValues = ValueClass(
  successfulResponse: createNewPasswordSuccessResponse,
  failureResponse: createNewPasswordFailedResponse,
  successfulBody: FormData.fromMap(successInput),
  failureBody: FormData.fromMap(failureInput),
  path: resetPasswordPath,
);
