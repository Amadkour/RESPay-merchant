import 'package:res_pay_merchant/features/dashboard/modules/more/modules/terms_and_conditions/provider/API/end_point.dart';

import '../../../../core/abstract_values.dart';

///------------- success Response ----------------------///

Map<String, dynamic> getAboutSuccessResponse = <String, dynamic>{
  "status_code": 200,
  "code": 1022,
  "hint": "Process successfully",
  "success": true,
  "data": <String, dynamic>{
    "message": "Successfully, displays the page!",
    "about_us":
        "This text is an example of what can be written on such a topic and it is repeated to be like the real one. This text is an example of what can be written on such a topic and it is repeated to be like the real one. This text is an example of what can be written on such a topic and it is repeated to be like the real one."
  }
};

///--------------- Failed Response ---------------//////

///--------------- Values ---------------//////
ValueClass getAboutValues = ValueClass(
  successfulResponse: getAboutSuccessResponse,
  path: getAboutPath,
  failureResponse: <String, dynamic>{},
);
