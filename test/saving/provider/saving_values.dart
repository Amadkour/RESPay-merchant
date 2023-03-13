import 'package:dio/dio.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/provider/API/end_point.dart';

import '../../core/abstract_values.dart';

///------------ Success Body ----------------///

Map<String, String> toggleSuccessBody = <String, String>{
  'user_uuid': 'success_uuid'
};

Map<String, dynamic> withdrawDepositSuccessBody = <String, dynamic>{
  'amount': 1000
};

///------------ Failure Body ----------------///

Map<String, String> toggleFailedBody = <String, String>{
  'user_uuid': 'failed_uuid'
};

Map<String, dynamic> withdrawDepositFailedBody = <String, dynamic>{
  'amount': -1000
};

///------------- success Response ----------------------///

Map<String, dynamic> getSavingListSuccessResponse = <String, dynamic>{
  "status_code": 200,
  "code": 1022,
  "hint": "Process successfully",
  "success": true,
  "data": <String, dynamic>{
    "otp": 7644,
    "message": "the otp sent successfully, please check your messages"
  }
};

Map<String, dynamic> toggleSavingSuccessResponse = <String, dynamic>{
  "status_code": 200,
  "code": 1020,
  "hint": "Processed successfully",
  "success": true,
  "data": <String, String>{"message": "Wallet is deactivated!."}
};

Map<String, dynamic> withdrawDepositSuccessResponse = <String, dynamic>{
  "status_code": 200,
  "code": 1020,
  "hint": "Processed successfully",
  "success": true,
  "data": <String, String>{
    "message": "Deposit success from wallet with amount 100"
  }
};

///--------------- Failed Response ---------------//////

Map<String, dynamic> toggleFailedResponse = <String, dynamic>{
  "status_code": 404,
  "code": 1044,
  "hint": "Resource not found",
  "success": false,
  "errors": <String, dynamic>{"error": "The wallet does not exist!"}
};

Map<String, dynamic> withdrawDepositFailedResponse = <String, dynamic>{
  "status_code": 422,
  "success": false,
  "code": 1422,
  "hint": "Unprocessable Entity",
  "errors": <String, dynamic>{
    "amount": <String>["The amount must be greater than or equal to 0."]
  }
};

///--------------- Values ---------------//////
ValueClass getSavingListValue = ValueClass(
  successfulResponse: getSavingListSuccessResponse,
  path: getSavingListPath,
  failureResponse: <String, dynamic>{},
);

/// Toggle
ValueClass toggleValue = ValueClass(
  successfulResponse: toggleSavingSuccessResponse,
  path: toggleSavingPath,
  successfulBody: FormData.fromMap(toggleSuccessBody),
  failureBody: FormData.fromMap(toggleFailedBody),
  failureResponse: toggleFailedResponse,
);

/// Withdraw
ValueClass withdrawValue = ValueClass(
  successfulResponse: withdrawDepositSuccessResponse,
  path: withdrawPath,
  successfulBody: FormData.fromMap(withdrawDepositSuccessBody),
  failureBody: FormData.fromMap(withdrawDepositFailedBody),
  failureResponse: withdrawDepositFailedResponse,
);

/// Deposit
ValueClass depositValue = ValueClass(
  successfulResponse: withdrawDepositSuccessResponse,
  path: addMoneyPath,
  successfulBody: FormData.fromMap(withdrawDepositSuccessBody),
  failureBody: FormData.fromMap(withdrawDepositFailedBody),
  failureResponse: withdrawDepositFailedResponse,
);
