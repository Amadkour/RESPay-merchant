import 'package:dio/dio.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/provider/API/end_point.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/provider/model/login_input.dart';

import '../../../core/abstract_values.dart';

///------------ success Login Inputs ----------------///

final Map<String, dynamic> successInput = <String, dynamic>{
  'identity_id': '20232023',
  'password': 'Mobile@2022',
};

///------------ failure Login Inputs ----------------///

final Map<String, dynamic> failureInput = <String, dynamic>{
  'identity_id': '20232023',
  'password': 'Mobile@2023',
};

///------------- success Login ----------------------///

Map<String, dynamic> loginSuccessResponse = <String, dynamic>{
  "status_code": 200,
  "code": 1022,
  "hint": "Process successfully",
  "success": true,
  "data": <String, dynamic>{
    "message": "You are logged in successfully!",
    "user": <String, dynamic>{
      "uuid": "e3e8e1bf-fb64-4b3b-826e-8a5e9ce3e456",
      "phone_number": "0555555556",
      "full_name": "Fady Gendy",
      "identity_id": 20222022,
      "email": "fady@test.com",
      "dob": "2003-02-02",
      "role": "User",
      "is_verified": true,
      "is_active": true,
      "pin_code": null,
      "touch_id_active": false,
      "face_id_active": false,
      "token":
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1dWlkIjoiZTNlOGUxYmYtZmI2NC00YjNiLTgyNmUtOGE1ZTljZTNlNDU2Iiwicm9sZSI6IlVzZXIifQ.rwO44ZB_BADLN-g28pr4yOKTbJ9rJuBEge4e07qDdBQ"
    }
  }
};

///--------------- Failed Login ---------------//////

Map<String, dynamic> loginFailedResponse = <String, dynamic>{
  "status_code": 400,
  "code": 1060,
  "hint": "Wrong Password",
  "success": false,
  "errors": <String, String>{"error": "The provided password is incorrect."}
};

///--------------- Values ---------------//////
ValueClass loginValues = ValueClass(
  successfulResponse: loginSuccessResponse,
  failureResponse: loginFailedResponse,
  successfulBody: FormData.fromMap(successInput),
  failureBody: FormData.fromMap(failureInput),
  path: loginPath,
);

final LoginInput loginInput = LoginInput(
  password: "Mobile@2022",
  osType: "android",
  deviceToken: "",
  identityId: "20222022",
);

final LoginInput failureLoginInput = LoginInput(
  password: "Mobile@2022",
  osType: "android",
  deviceToken: "",
  identityId: "20222023",
);
