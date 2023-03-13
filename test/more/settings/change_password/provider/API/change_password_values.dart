import 'package:dio/dio.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/settings/modules/change_password/provider/API/end_point.dart';

import '../../../../../core/abstract_values.dart';

final Map<String, dynamic> changePasswordSuccessResponse = <String, dynamic>{
  "status_code": 200,
  "code": 1022,
  "hint": "Process successfully",
  "success": true,
  "data": <String, String>{"message": "Your password changed successfully"}
};

final Map<String, dynamic> changePasswordSuccessBody = <String, dynamic>{
  "old_password": "Mobile@2022",
  "new_password": "Mobile@2023",
  "new_password_confirmation": "Mobile@2023",
};

ValueClass changePasswordValues = ValueClass(
    path: changePasswordPath,
    successfulResponse: changePasswordSuccessResponse,
    failureResponse: <String, dynamic>{},
    successfulBody: FormData.fromMap(changePasswordSuccessBody));
