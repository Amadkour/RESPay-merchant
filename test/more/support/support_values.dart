import 'package:dio/dio.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/support/provider/end_points.dart';

import '../../core/abstract_values.dart';

///------------ success addNewSupportIssue Inputs ----------------///

final Map<String, dynamic> sendIssueSuccessInput = <String,dynamic>{
  "full_name": "hussein hamed",
  "email": "hussein@gmail.com",
  "message": "test issue",
};

///------------ failure addNewSupportIssue Inputs ----------------///

final Map<String, dynamic> sendIssueFailureInput = <String, dynamic>{
  "full_name": "",
  "email": "hussein@gmail.com",
  "message": "test issue",
};

///--------------- success addNewSupportIssue ---------------//////

Map<String, dynamic> addNewSupportIssueSuccessResponse = <String, dynamic>{"status_code": 200,
  "code": 1022,
  "hint": "Process successfully",
  "success": true,
  "data": <String, dynamic>{
    "message": "We received your message, thank you!"
  }
};

///--------------- Failed addNewSupportIssue ---------------//////
///
Map<String, dynamic> addNewSupportIssueInFailedResponse = <String, dynamic>{
  "success": false,
  "status_code": 422,
  "code": 1422,
  "hint": "Unprocessable Entity",
  "errors": <String, dynamic>{
    "full_name": <dynamic>[
      "full name is required."
    ],
  }
};


ValueClass sendSupportValue = ValueClass(
  successfulResponse:  addNewSupportIssueSuccessResponse,
  failureResponse:  addNewSupportIssueInFailedResponse,
  successfulBody: FormData.fromMap(sendIssueSuccessInput),
  failureBody: FormData.fromMap(sendIssueFailureInput),
  path: support,
);
