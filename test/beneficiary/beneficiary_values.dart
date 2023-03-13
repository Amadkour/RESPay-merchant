import 'package:dio/dio.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/api/end_point.dart';

import '../core/abstract_values.dart';

///------------ success addNewTransferBeneficiary Inputs ----------------///

final Map<String, dynamic> successAddNewTransferBeneficiaryInput = <String, dynamic>{
  "type": "external",
  "method": "RES App",
  "first_name": "New Beneficiary",
  "last_name": "hussein",
  "phone_number": "05019069388",
  "country":1,
  "currency":2,
  "relationship":"Relatives / Friends"
};

///------------ failure addNewTransferBeneficiary Inputs ----------------///

final Map<String, dynamic> failureAddNewTransferBeneficiaryInput = <String, dynamic>{
  "type": "external",
  "method": "RES App",
  "first_name": "New Beneficiary",
  "last_name": "hussein",
  "phone_number": "05019069300",
  "country":1,
  "currency":2,
  "relationship":"Relatives / Friends"
};

///------------- success addNewTransferBeneficiary ----------------------///

Map<String, dynamic> addNewTransferBeneficiarySuccessResponse = <String, dynamic>{
  "status_code": 201,
  "code": 1021,
  "hint": "Resource created successfully",
  "success": true,
  "data": <String,dynamic>{
    "message": "Beneficiary Added successfully",
    "beneficiary": <String,dynamic>{
      "uuid": "545b8065-24e6-413a-80b5-c7d7570d588f",
      "user_uuid": "545b8065-24e6-413a-80b5-c7d7570d588f",
      "type": "internal",
      "method": "RES App",
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

Map<String, dynamic> getAllTransferBeneficiariesSuccessResponse = <String, dynamic>{
  "status_code": 200,
  "code": 1022,
  "hint": "Process successfully",
  "success": true,
  "data": <String,dynamic>{
    "beneficiaries": <dynamic>[
      <String,dynamic>{
        "uuid": "d51aa06f-c627-47f0-a905-8e42b8ac8795",
        "user_uuid": "1f66eaf0-295e-4df1-b82c-c145f34b11a5",
        "type": "external",
        "method": "RES App",
        "country_id": 1,
        "currency_id": 1,
        "first_name": "hussein",
        "last_name": "hamed",
        "relation": "Relatives / Friends",
        "is_active": true,
        "is_favorite": false,
        "phone_number": "0566556464",
        "bank_name": null,
        "account_number": null,
        "iban": null,
        "swift_code": null,
        "created_at": "1 day ago"
      },
      <String,dynamic>{
        "uuid": "222b158b-73a9-4c6b-a499-1ddee5defa39",
        "user_uuid": "1f66eaf0-295e-4df1-b82c-c145f34b11a5",
        "type": "external",
        "method": "RES App",
        "country_id": 1,
        "currency_id": 1,
        "first_name": "hussein",
        "last_name": "hamed",
        "relation": "Relatives / Friends",
        "is_active": true,
        "is_favorite": false,
        "phone_number": "0564644646",
        "bank_name": null,
        "account_number": null,
        "iban": null,
        "swift_code": null,
        "created_at": "1 day ago"
      },
    ]
  }
};
Map<String, dynamic> getAllRequestBeneficiariesSuccessResponse = <String, dynamic>{
  "status_code": 200,
  "code": 1022,
  "hint": "Process successfully",
  "success": true,
  "data": <String,dynamic>{
    "beneficiaries": <dynamic>[
      <String,dynamic>{
        "uuid": "d51aa06f-c627-47f0-a905-8e42b8ac8795",
        "user_uuid": "1f66eaf0-295e-4df1-b82c-c145f34b11a5",
        "type": "external",
        "method": "Request Money",
        "country_id": 1,
        "currency_id": 1,
        "first_name": "hussein",
        "last_name": "hamed",
        "relation": "Relatives / Friends",
        "is_active": true,
        "is_favorite": false,
        "phone_number": "0566556464",
        "bank_name": null,
        "account_number": null,
        "iban": null,
        "swift_code": null,
        "created_at": "1 day ago"
      },
      <String,dynamic>{
        "uuid": "222b158b-73a9-4c6b-a499-1ddee5defa39",
        "user_uuid": "1f66eaf0-295e-4df1-b82c-c145f34b11a5",
        "type": "external",
        "method": "Request Money",
        "country_id": 1,
        "currency_id": 1,
        "first_name": "hussein",
        "last_name": "hamed",
        "relation": "Relatives / Friends",
        "is_active": true,
        "is_favorite": false,
        "phone_number": "0564644646",
        "bank_name": null,
        "account_number": null,
        "iban": null,
        "swift_code": null,
        "created_at": "1 day ago"
      },
    ]
  }
};
Map<String, dynamic> getAllGiftBeneficiariesSuccessResponse = <String, dynamic>{
  "status_code": 200,
  "code": 1022,
  "hint": "Process successfully",
  "success": true,
  "data": <String, dynamic>{
    "beneficiaries": <dynamic>[
      <String, dynamic>{
        "uuid": "d51aa06f-c627-47f0-a905-8e42b8ac8795",
        "user_uuid": "1f66eaf0-295e-4df1-b82c-c145f34b11a5",
        "type": "external",
        "method": "Gift",
        "country_id": null,
        "currency_id":null ,
        "first_name": "hussein",
        "last_name": "hamed",
        "relation": null,
        "is_active": true,
        "is_favorite": false,
        "phone_number": "0566556464",
        "bank_name": null,
        "account_number": null,
        "iban": null,
        "swift_code": null,
        "created_at": "1 day ago"
      },
      <String, dynamic>{
        "uuid": "d51aa06f-c627-47f0-a905-8e42b8ac8795",
        "user_uuid": "1f66eaf0-295e-4df1-b82c-c145f34b11a6",
        "type": "external",
        "method": "Gift",
        "country_id": null,
        "currency_id":null ,
        "first_name": "hussein",
        "last_name": "hamed",
        "relation": null,
        "is_active": true,
        "is_favorite": false,
        "phone_number": "0566556464",
        "bank_name": null,
        "account_number": null,
        "iban": null,
        "swift_code": null,
        "created_at": "1 day ago"
      },
    ]
  }
};


///--------------- Failed AddNewTransferBeneficiaryFailed---------------//////


Map<String, dynamic> addNewTransferBeneficiaryFailedResponse = <String, dynamic>{
  "status_code":404,
  "code":1044,
  "hint":"Resource not found",
  "success":false,
  "errors": <String,dynamic>{
    "user_uuid": <dynamic>[
      "phone number is already taken"
    ]
  }
};

///--------------- Failed GetAllTransferBeneficiaryFailed---------------//////

Map<String, dynamic> getBeneficiariesFailedResponse = <String, dynamic>{
  "status_code":404,
  "code":1044,
  "hint":"Resource not found",
  "success":false,
  "errors": <String,dynamic>{
    "user_uuid": <dynamic>[
      "phone number is already taken"
    ]
  }
};


///--------------- Values ---------------//////
ValueClass addNewTransferBeneficiaryValues = ValueClass(
  successfulResponse: addNewTransferBeneficiarySuccessResponse,
  failureResponse: addNewTransferBeneficiaryFailedResponse,
  successfulBody: FormData.fromMap(successAddNewTransferBeneficiaryInput),
  failureBody: FormData.fromMap(failureAddNewTransferBeneficiaryInput),
  path: createNewBeneficiary,
);

ValueClass getAllGiftBeneficiariesValues = ValueClass(
  successfulResponse: getAllGiftBeneficiariesSuccessResponse,
  failureResponse: getBeneficiariesFailedResponse,
  successfulBody: FormData.fromMap(successAddNewTransferBeneficiaryInput),
  failureBody: FormData.fromMap(failureAddNewTransferBeneficiaryInput),
  path: loadBeneficiaries,
);

ValueClass getAllTransferBeneficiariesValues = ValueClass(
  successfulResponse: getAllTransferBeneficiariesSuccessResponse,
  failureResponse: getBeneficiariesFailedResponse,
  successfulBody: FormData.fromMap(successAddNewTransferBeneficiaryInput),
  failureBody: FormData.fromMap(failureAddNewTransferBeneficiaryInput),
  path: loadBeneficiaries,
);

ValueClass getAllRequestBeneficiariesValues = ValueClass(
  successfulResponse: getAllRequestBeneficiariesSuccessResponse,
  failureResponse: getBeneficiariesFailedResponse,
  successfulBody: FormData.fromMap(successAddNewTransferBeneficiaryInput),
  failureBody: FormData.fromMap(failureAddNewTransferBeneficiaryInput),
  path: loadBeneficiaries,
);
