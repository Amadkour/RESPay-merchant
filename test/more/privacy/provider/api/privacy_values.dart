import 'package:res_pay_merchant/features/dashboard/modules/more/modules/terms_and_conditions/provider/API/end_point.dart';

import '../../../../core/abstract_values.dart';

///------------- success Response ----------------------///

Map<String, dynamic> getPrivacySuccessResponse = <String, dynamic>{
  "status_code": 200,
  "code": 1022,
  "hint": "Process successfully",
  "success": true,
  "data": <String, dynamic>{
    "message": "Successfully, displays the page!",
    "privacy":
        "This text is an example of what can be written on such a topic and it is repeated to be like the real one. This text is an example of what can be written on such a topic and it is repeated to be like the real one. This text is an example of what can be written on such a topic and it is repeated to be like the real one."
  }
};

///--------------- Failed Response ---------------//////

///--------------- Values ---------------//////
ValueClass getPrivacyAboutValues = ValueClass(
  successfulResponse: getPrivacySuccessResponse,
  path: getPrivacyPath,
  failureResponse: <String, dynamic>{},
);
