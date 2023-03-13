import 'package:dio/dio.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/provider/API/end_point.dart';

import '../../core/abstract_values.dart';

///------------ Success Body ----------------///

Map<String, dynamic> addRoleSuccessBody = <String, dynamic>{
  'from': 1.0,
  'to': 1000.0,
  'value': 20.0,
  'type': 'buying',
  'user_uuid': 'success_uuid',
};

Map<String, String> deleteRoleSuccessBody = <String, String>{
  'uuid': 'roleUUID',
  'user_uuid': 'success_userUUID',
};
Map<String, String> toggleRoleSuccessBody = <String, String>{
  'uuid': 'roleUUID',
  'user_uuid': 'success_userUUID',
};
Map<String, dynamic> updateRoleSuccessBody = <String, dynamic>{
  'uuid': 'roleUUID',
  'user_uuid': 'success_uuid',
  'from': 10.0,
  'to': 1000.0,
  'value': 20.0,
  'type': 'buying',
  'is_active': 1,
};

///------------ Failure Body ----------------///

Map<String, dynamic> addRoleFailedBody = <String, dynamic>{
  'from': 1.0,
  'to': 1000.0,
  'value': 20.0,
  'type': 'buying',
  'user_uuid': 'fail_uuid',
};

Map<String, dynamic> deleteRoleFailedBody = <String, String>{
  'uuid': 'roleUUID',
  'user_uuid': 'fail_userUUID',
};
Map<String, dynamic> toggleRoleFailedBody = <String, String>{
  'uuid': 'roleUUID',
  'user_uuid': 'fail_userUUID',
};
Map<String, dynamic> updateRoleFailedBody = <String, dynamic>{
  'uuid': 'roleUUID',
  'user_uuid': 'fail_userUUID',
  'from': 10.0,
  'to': 1000.0,
  'value': 20.0,
  'type': 'buying',
  'is_active': 1,
};

///------------- success Response ----------------------///

Map<String, dynamic> addRoleSuccessResponse = <String, dynamic>{
  "status_code": 201,
  "code": 1021,
  "hint": "Resource created successfully",
  "success": true,
  "data": <String, dynamic>{
    "message": "Saving Rule Created Successfully",
    "rule": <String, dynamic>{
      "uuid": "32754f83-73a2-47ab-b0f6-e2ad3b4d18aa",
      "wallet_uuid": "ca70e266-e03e-4d32-b4ac-d777cfceffc0",
      "user_uuid": "99077c61-2043-47c1-874c-400b3f7ff6a0",
      "form": 1,
      "to": 50,
      "value": 10,
      "is_active": false,
      "type": "buying",
      "created_at": "2023-01-18T09:56:58.000000Z"
    }
  }
};

Map<String, dynamic> updateRoleSuccessResponse = <String, dynamic>{
  "status_code": 200,
  "code": 1020,
  "hint": "Processed successfully",
  "success": true,
  "data": <String, dynamic>{
    "message": "Saving Rule Updated Successfully",
    "rule": <String, dynamic>{
      "uuid": "32754f83-73a2-47ab-b0f6-e2ad3b4d18aa",
      "wallet_uuid": "ca70e266-e03e-4d32-b4ac-d777cfceffc0",
      "user_uuid": "99077c61-2043-47c1-874c-400b3f7ff6a0",
      "form": 50,
      "to": 200,
      "value": 10,
      "is_active": true,
      "type": "buying",
      "created_at": "2023-01-18T09:56:58.000000Z"
    }
  }
};

Map<String, dynamic> toggleRoleSuccessResponse = <String, dynamic>{
  "status_code": 200,
  "code": 1020,
  "hint": "Processed successfully",
  "success": true,
  "data": <String, String>{"message": "Rule is deactivated!."}
};
Map<String, dynamic> deleteRoleSuccessResponse = <String, dynamic>{
  "status_code": 200,
  "code": 1020,
  "hint": "Processed successfully",
  "success": true,
  "data": <String, String>{"message": "Saving Rule Deleted Successfully"}
};

///--------------- Failed Response ---------------//////

Map<String, dynamic> failureResponse = <String, dynamic>{
  "status_code": 404,
  "code": 1044,
  "hint": "Resource not found",
  "success": false,
  "errors": <String, dynamic>{"error": "The wallet does not exist!"}
};

///--------------- Values ---------------//////
/// Add Role
ValueClass addRoleValue = ValueClass(
  successfulResponse: addRoleSuccessResponse,
  successfulBody: FormData.fromMap(addRoleSuccessBody),
  failureResponse: failureResponse,
  failureBody: FormData.fromMap(addRoleFailedBody),
  path: addRolePath,
);

/// Toggle Role
ValueClass toggleRoleValue = ValueClass(
  successfulResponse: toggleRoleSuccessResponse,
  successfulBody: FormData.fromMap(toggleRoleSuccessBody),
  failureBody: FormData.fromMap(toggleRoleFailedBody),
  failureResponse: failureResponse,
  path: toggleRolePath,
);

/// Delete Role
ValueClass deleteRoleValue = ValueClass(
  successfulResponse: deleteRoleSuccessResponse,
  successfulBody: FormData.fromMap(deleteRoleSuccessBody),
  failureBody: FormData.fromMap(deleteRoleFailedBody),
  failureResponse: failureResponse,
  path: deleteRolePath,
);

/// Update Role
ValueClass updateRoleValue = ValueClass(
  successfulResponse: updateRoleSuccessResponse,
  successfulBody: FormData.fromMap(updateRoleSuccessBody),
  failureBody: FormData.fromMap(updateRoleFailedBody),
  failureResponse: failureResponse,
  path: updateRolePath,
);
