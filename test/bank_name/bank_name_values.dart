import 'package:dio/dio.dart';
import 'package:res_pay_merchant/features/payment/modules/bank_name/provider/api/end_point.dart';
import '../core/abstract_values.dart';
///------------- success getBankNames ----------------------///

Map<String, dynamic> getBankNamesSuccessResponse = <String, dynamic>{
  "status_code": 200,
  "code": 1022,
  "hint": "Process successfully",
  "success": true,
  "data": <String, dynamic>{
    "banks": <dynamic>[
      <String, dynamic> {
        "id": 1,
        "uuid": "2323677f-68ec-4ce5-900f-689d7293a10b",
        "name": "Saudi National Bank",
        "country_id": 1,
        "is_active": true,
        "is_default": false
      },
      <String, dynamic> {
        "id": 3,
        "uuid": "1f3ed0eb-999f-4d12-a940-cbe7e8119bc5",
        "name": "Al Jazira Bank",
        "country_id": 2,
        "is_active": true,
        "is_default": false
      },
      <String, dynamic>  {
        "id": 4,
        "uuid": "f8c974f9-0054-48f8-846f-2a98c53a262e",
        "name": "Al Rajhi Bank",
        "country_id": 2,
        "is_active": true,
        "is_default": false
      },
      <String, dynamic>{
        "id": 6,
        "uuid": "abf14b43-738e-490b-951f-960835de0c79",
        "name": "Arab National Bank",
        "country_id": 1,
        "is_active": true,
        "is_default": false
      }
    ]
  }
};

///--------------- Failed getBankNames ---------------//////

Map<String, dynamic> getBankNamesFailed =
    <String, dynamic>{
  "status_code": 404,
  "code": 1044,
  "hint": "Resource not found",
  "success": false,
  "errors": <String, dynamic>{"error": "User not found!"}
};

///--------------- Values ---------------//////
ValueClass bankNamesValue = ValueClass(
  successfulResponse: getBankNamesSuccessResponse,
  failureResponse: getBankNamesFailed,
  successfulBody: FormData.fromMap(<String, dynamic>{}),
  failureBody: FormData.fromMap(<String, dynamic>{}),
  path: loadBankNames,
);
