import 'package:dio/dio.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/language/provider/API/end_point.dart';

import '../../../../core/abstract_values.dart';

///------------ Success Body ----------------///
Map<String, dynamic> setLanguageSuccessBody = <String, String>{
  'locale': "locale"
};

///------------ Failure Body ----------------///

///------------- success Response ----------------------///

Map<String, dynamic> getLanguageSuccessResponse = <String, dynamic>{
  "status_code": 200,
  "code": 1022,
  "hint": "Process successfully",
  "success": true,
  "data": <String, dynamic>{
    "locales": <dynamic>[
      <String, dynamic>{
        "name": "Arabic",
        "locale": "ar",
        "icon":
        "https://authentication.eightyythree.com/storage/uploads/locales/ar.svg"
      },
      <String, dynamic>{
        "name": "English",
        "locale": "en",
        "icon":
        "https://authentication.eightyythree.com/storage/uploads/locales/en.svg"
      }
    ]
  }
};


Map<String, dynamic> setLanguageSuccessResponse = <String, dynamic>{

  "status_code": 200,
  "code": 1022,
  "hint": "Process successfully",
  "success": true,
  "data": <String, dynamic>{
    "message": "Successfully, updated locale!",
    "user": <String, dynamic>{
      "uuid": "5d4014d7-932d-448c-a9b3-bcedffc66e7f",
      "phone_number": "0522222222",
      "full_name": "Mohamed",
      "identity_id": 20222022,
      "email": "mohamed22@gmail.com",
      "dob": "2005-02-28",
      "image": null,
      "role": "User",
      "locale": "en",
      "is_verified": true,
      "is_active": true,
      "pin_code": "1234",
      "touch_id_active": false,
      "face_id_active": false,
      "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1dWlkIjoiNWQ0MDE0ZDctOTMyZC00NDhjLWE5YjMtYmNlZGZmYzY2ZTdmIiwicm9sZSI6IlVzZXIifQ.MEYDu44pvMg4RVgAdDfU4VsZgo9VnqdDJBpXvaK2osw"
    }
  }
};


///--------------- Failed Response ---------------//////

///--------------- Values ---------------//////
ValueClass getLanguageValues = ValueClass(
  successfulResponse: getLanguageSuccessResponse,
  path: getLanguagePath,
  failureResponse: <String, dynamic>{},
);
ValueClass setLanguageValues = ValueClass(
  successfulResponse: setLanguageSuccessResponse,
  successfulBody: FormData.fromMap(setLanguageSuccessBody),
  path: setLanguagePath,
  failureResponse: <String, dynamic>{},
);
