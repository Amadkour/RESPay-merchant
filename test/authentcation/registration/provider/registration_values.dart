import 'package:dio/dio.dart';
import 'package:res_pay_merchant/features/authentication/modules/registration/providers/Api/end_point.dart';
import 'package:res_pay_merchant/features/authentication/modules/registration/providers/models/register_inputs.dart';

import '../../../core/abstract_values.dart';

///------------ success Registration Inputs ----------------///

final Map<String, dynamic> successInput = <String, dynamic>{
  'full_name': 'amira',
  'phone_number': '5012345678',
  'email': 'amira@gmail.com',
  'password': 'Mm@223344',
  'password_confirmation': 'Mm@223344',
  'identity_id': '20552055',
  'is_merchant': 0,
  'dob': '1996-02-11'
};

///------------ failure Registration Inputs ----------------///

final Map<String, dynamic> failureInput = <String, dynamic>{
  'full_name': 'amira',
  'phone_number': '5012345678',
  'email': 'mira@gmail.com',
  'password': 'Mm@223344',
  'password_confirmation': 'Mm@223344',
  'identity_id': '20552059',
  'is_merchant': '0',
  'dob': '1996-02-11'
};

///------------- success registration ----------------------///

Map<String, dynamic> successRegistration = <String, dynamic>{
  "status_code": 200,
  "code": 1022,
  "hint": "Process successfully",
  "success": true,
  "data": <String, dynamic>{"otp": 7159, "message": "the otp sent successfully, please check your messages"}
};

///--------------- Failed registration ---------------//////

Map<String, dynamic> failedRegistration = <String, dynamic>{
  "status_code": 422,
  "success": false,
  "code": 1422,
  "hint": "Unprocessable Entity",
  "errors": <String, dynamic>{
    "phone_number": <String>["The phone number has already been taken."]
  }
};

const RegisterInputs registrationInputs = RegisterInputs(
  fullName: 'amira',
  phone: '5012345678',
  email: 'amira@gmail.com',
  password: 'Mm@223344',
  passwordConfirmation: 'Mm@223344',
  id: '20552055',
  birthday: '1996-02-11',
  
);

ValueClass registrationValues = ValueClass(
  successfulResponse: successRegistration,
  failureResponse: failedRegistration,
  successfulBody: FormData.fromMap(registrationInputs.toMap()),
  failureBody: FormData.fromMap(failureInput),
  path: registrationPath,
);
