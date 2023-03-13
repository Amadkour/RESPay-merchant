import 'package:dio/dio.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/profile/provider/end_points.dart';

import '../../core/abstract_values.dart';

///------------ success showProfile Inputs ----------------///

final Map<String, dynamic> showProfileSuccessInput = <String,dynamic>{
  "full_name": "hussein hamed",
  "email": "hussein@gmail.com",
  "message": "test issue",
};

///------------ success updateProfile Inputs ----------------///

final Map<String, dynamic> updateProfileSuccessInput = <String,dynamic>{
  "user_uuid": "8e329505-4eac-4f23-b9ce-9d3a2cc12abf",
  "phone_number": "0500500522",
  "email": "testProfile@test.com",
  "identity_id":"123456789",
  "dob":"2000-01-01",
  "full_name":"tes profile",
  "image":"Atsgx7T5O/defaultimage.png"
};

///------------ failure ShowProfile Inputs ----------------///

final Map<String, dynamic> showProfileFailureInput = <String, dynamic>{
  "email": "hussein@gmail.com",
  "message": "test issue",
};


///------------ failure UpdateProfile Inputs ----------------///

final Map<String, dynamic> updateProfileFailureInput = <String, dynamic>{
  "phone_number": "0500500522",
  "email": "testProfile@test.com",
  "identity_id":"123456789",
  "dob":"2000-01-01",
  "full_name":"tes profile",
  "image":"Atsgx7T5O/defaultimage.png"
};


///--------------- success showProfile ---------------//////

Map<String, dynamic> showProfileSuccessResponse = <String, dynamic>{
  "status_code": 200,
  "code": 1022,
  "hint": "Process successfully",
  "success": true,
  "data": <String, dynamic>{
    "message": "Successfully, updated profile information!",
    "user":<String, dynamic> {
      "uuid": "8e329505-4eac-4f23-b9ce-9d3a2cc12abf",
      "phone_number": "0500500522",
      "full_name": "tes profile",
      "identity_id": 123456789,
      "email": "testProfile@test.com",
      "dob": "2000-01-01",
      "image": "https://authentication.eightyythree.com/storage/uploads/users/717283474_defaultimage.png",
      "role": null,
      "locale": null,
      "is_verified": true,
      "is_active": true,
      "pin_code": null,
      "touch_id_active": false,
      "face_id_active": false,
      "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1dWlkIjoiOGUzMjk1MDUtNGVhYy00ZjIzLWI5Y2UtOWQzYTJjYzEyYWJmIiwicm9sZSI6bnVsbH0.8jwF8RuvOXNoIJo5Bj_pgaRDwzyS4lC7ib1pOkF1hSQ"
    }
  }
};

///--------------- success updateProfile ---------------//////

Map<String, dynamic> updateProfileSuccessResponse = <String, dynamic>{
  "status_code": 200,
  "code": 1022,
  "hint": "Process successfully",
  "success": true,
  "data": <String, dynamic>{
    "message": "Successfully, displayed profile information!",
    "user": <String, dynamic>{
      "uuid": "8e329505-4eac-4f23-b9ce-9d3a2cc12abf",
      "phone_number": "0500500522",
      "full_name": "tes profile",
      "identity_id": 123456789,
      "email": "testProfile@test.com",
      "dob": "2000-01-01",
      "image": "https://authentication.eightyythree.com/storage/uploads/users/717283474_defaultimage.png",
      "role": null,
      "locale": null,
      "is_verified": true,
      "is_active": true,
      "pin_code": null,
      "touch_id_active": false,
      "face_id_active": false,
      "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1dWlkIjoiOGUzMjk1MDUtNGVhYy00ZjIzLWI5Y2UtOWQzYTJjYzEyYWJmIiwicm9sZSI6bnVsbH0.8jwF8RuvOXNoIJo5Bj_pgaRDwzyS4lC7ib1pOkF1hSQ"
    }
  }
};


///--------------- Failed showProfile ---------------//////

Map<String, dynamic> showProfileFailureResponse = <String, dynamic>{
  "success": false,
  "status_code": 422,
  "code": 1422,
  "hint": "Unprocessable Entity",
  "errors": <String, dynamic>{
    "user_uuid": <dynamic>[
      "The user uuid field is required."
    ]
  }
};

///--------------- Failed updateProfile ---------------//////

Map<String, dynamic> updateProfileFailedResponse = <String, dynamic>{
  "success": false,
  "status_code": 422,
  "code": 1422,
  "hint": "Unprocessable Entity",
  "errors": <String, dynamic>{
    "full_name": <dynamic>[
      "full name is required."
    ],
  }
};

ValueClass showProfileValues = ValueClass(
  successfulResponse:  showProfileSuccessResponse,
  failureResponse:  showProfileFailureResponse,
  successfulBody: FormData.fromMap(showProfileSuccessInput),
  failureBody: FormData.fromMap(showProfileFailureInput),
  path: showProfilePath,
);

ValueClass updateProfileValues = ValueClass(
  successfulResponse:  updateProfileSuccessResponse,
  failureResponse:  updateProfileFailedResponse,
  successfulBody: FormData.fromMap(updateProfileSuccessInput),
  failureBody: FormData.fromMap(updateProfileFailureInput),
  path: updateProfilePath,
);
