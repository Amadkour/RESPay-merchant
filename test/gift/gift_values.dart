import 'package:dio/dio.dart';
import 'package:res_pay_merchant/features/payment/modules/gift/provider/api/end_points.dart';

import '../core/abstract_values.dart';

///------------ success addNewGiftBeneficiary Inputs ----------------///

final Map<String, dynamic> giftSuccessInput = <String, dynamic>{
  "phone_number": "050505055535",
  "type": "internal",
  "method": "Gift",
  "first_name": "hussein",
  "last_name": "hamed",
};

///------------ failure addNewGiftBeneficiary Inputs ----------------///

final Map<String, dynamic> giftFailureInput = <String, dynamic>{
  "phone_number": "",
  "type": "internal",
  "method": "Gift",
  "first_name": "hussein",
  "last_name": "hamed",
};

///------------- success addNewGiftBeneficiary ----------------------///

Map<String, dynamic> addNewGiftBeneficiarySuccessResponse = <String, dynamic>{
  "status_code": 201,
  "code": 1021,
  "hint": "Resource created successfully",
  "success": true,
  "data": <String, dynamic>{
    "message": "Beneficiary Added successfully",
    "beneficiary": <String, dynamic>{
      "uuid": "1d4245ce-3c0d-40c9-8ab6-8ec3a1cd836a",
      "user_uuid": "545b8065-24e6-413a-80b5-c7d7570d588f",
      "type": "internal",
      "method": "Gift",
      "country_id": null,
      "currency_id": null,
      "first_name": "Gift",
      "last_name": "Beneficiary",
      "relation": null,
      "is_active": true,
      "is_favorite": false,
      "phone_number": "0500088991",
      "bank_name": null,
      "account_number": null,
      "iban": null,
      "swift_code": null,
      "created_at": "1 second ago"
    }
  }
};

///--------------- Failed addNewGiftBeneficiary ---------------//////

Map<String, dynamic> addNewGiftBeneficiaryFailedResponseWithUserNotFound =
    <String, dynamic>{
  "status_code": 404,
  "code": 1044,
  "hint": "Resource not found",
  "success": false,
  "errors": <String, dynamic>{"error": "User not found!"}
};

///--------------- Values ---------------//////
ValueClass addNewGiftBeneficiaryValues = ValueClass(
  successfulResponse: addNewGiftBeneficiarySuccessResponse,
  failureResponse: addNewGiftBeneficiaryFailedResponseWithUserNotFound,
  successfulBody: FormData.fromMap(giftSuccessInput),
  failureBody: FormData.fromMap(giftFailureInput),
  path: createNewGiftBeneficiary,
);

final Map<String, dynamic> sendGiftSuccessInput = <String, dynamic>{
  "amount": "100",
  "beneficiary_uuid": "34543534534sdfsdfswdfwsf",
  "purpose": "test",
  "category": "32423432432432",
  "note": "test",
};

///------------ failure addNewGiftBeneficiary Inputs ----------------///

final Map<String, dynamic> sendGiftFailureInput = <String, dynamic>{
  "amount": "",
  "beneficiary_uuid": "34543534534sdfsdfswdfwsf",
  "purpose": "test",
  "category": "32423432432432",
  "note": "test",
};

Map<String, dynamic> sendGiftSuccessResponse = <String, dynamic>{
  "status_code": 200,
  "code": 1020,
  "hint": "Processed successfully",
  "success": true,
  "data": <String, dynamic>{
    "message": "Transfer Success",
    "amount": 100,
    "from": <dynamic>["HusseinUser", "b377579e-e1b2-4754-a21f-84360fa3f5a7"],
    "to": <dynamic>["Gift Beneficiary", "b377579e-e1b2-4754-a21f-84360fa3f5a7"],
    "type": "internal - Gift",
    "date": "1 second ago"
  }
};

Map<String, dynamic> sendGiftFailedResponseWithUserNotFound = <String, dynamic>{
  "status_code": 404,
  "code": 1044,
  "hint": "Resource not found",
  "success": false,
  "errors": <String, dynamic>{"error": "user.beneficiary.not_found"}
};

ValueClass sendGiftValue = ValueClass(
  successfulResponse: sendGiftSuccessResponse,
  failureResponse: sendGiftFailedResponseWithUserNotFound,
  successfulBody: FormData.fromMap(sendGiftSuccessInput),
  failureBody: FormData.fromMap(sendGiftFailureInput),
  path: giftRequest,
);
