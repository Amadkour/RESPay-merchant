import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/constant/shared_orefrences_keys.dart';
import 'package:res_pay_merchant/features/payment/modules/request/provider/api/end_points.dart';

import '../core/abstract_values.dart';

///------------ success addNewRequestBeneficiary Inputs ----------------///

final Map<String, dynamic> addNewRequestBeneficiarySuccessInput =
    <String, dynamic>{
  "phone_number": "0500099991",
  "type": "internal",
  "method": "Request Money",
  "first_name": "HUSSEIN",
  "last_name": "HAMED",
  "user_uuid": userUUID
};

///------------ failure addNewRequestBeneficiary Inputs ----------------///

final Map<String, dynamic> addNewRequestBeneficiaryFailureInput =
    <String, dynamic>{
  "phone_number": "0500099992",
  "type": "internal",
  "method": "Request Money",
  "first_name": "HUSSEIN",
  "last_name": "HAMED",
  "user_uuid": userUUID
};

///------------- success addNewRequestBeneficiary ----------------------///

Map<String, dynamic> addNewRequestBeneficiarySuccessResponse =
    <String, dynamic>{
  "status_code": 201,
  "code": 1021,
  "hint": "Resource created successfully",
  "success": true,
  "data": <String, dynamic>{
    "message": "Beneficiary Added successfully",
    "beneficiary": <String, dynamic>{
      "uuid": "545b8065-24e6-413a-80b5-c7d7570d588f",
      "user_uuid": "545b8065-24e6-413a-80b5-c7d7570d588f",
      "type": "internal",
      "method": "Request Money",
      "country_id": null,
      "currency_id": null,
      "first_name": "New Beneficiary",
      "last_name": "Last",
      "relation": null,
      "is_active": true,
      "is_favorite": false,
      "phone_number": "0500099991",
      "bank_name": null,
      "account_number": null,
      "iban": null,
      "swift_code": null,
      "created_at": "1 second ago"
    }
  }
};

///--------------- Failed AddNewRequestBeneficiaryFailedResponseWithUserNotFound ---------------//////

Map<String, dynamic> addNewRequestBeneficiaryFailedResponseWithUserNotFound =
    <String, dynamic>{
  "status_code": 404,
  "code": 1044,
  "hint": "Resource not found",
  "success": false,
  "errors": <String, dynamic>{"error": "User not found!"}
};

///--------------- Values ---------------//////
ValueClass addNewRequestBeneficiaryValues = ValueClass(
  successfulResponse: addNewRequestBeneficiarySuccessResponse,
  failureResponse: addNewRequestBeneficiaryFailedResponseWithUserNotFound,
  successfulBody: FormData.fromMap(addNewRequestBeneficiarySuccessInput),
  failureBody: FormData.fromMap(addNewRequestBeneficiaryFailureInput),
  path: createNewRequestBeneficiary,
);
