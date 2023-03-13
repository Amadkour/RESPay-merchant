import 'package:res_pay_merchant/features/dashboard/modules/more/modules/terms_and_conditions/provider/API/end_point.dart';

import '../../../../core/abstract_values.dart';

///------------- success Response ----------------------///

Map<String, dynamic> getTermsPrivacyAboutSuccessResponse = <String, dynamic>{
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

///--------------- Failed Response ---------------//////

///--------------- Values ---------------//////
ValueClass getTermsPrivacyAboutValues = ValueClass(
  successfulResponse: getTermsPrivacyAboutSuccessResponse,
  path: getTermsPath,
  failureResponse: <String, dynamic>{},
);
