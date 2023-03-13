import 'package:dio/dio.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/shipping_location/provider/API/end_point.dart';

import '../../../../core/abstract_values.dart';

///------------ Success Body ----------------///

Map<String, dynamic> deleteAddressSuccessBody = <String, dynamic>{
  "address_uuid": "93aea30e-86b2-44a9-aa80-d8fe0d3eb90d",
  "user_uuid": "8a67612b-a3ad-4c21-9b12-38b0342c1e1d"
};

Map<String, dynamic> updateAddressSuccessBody = <String, dynamic>{
  'address_uuid': "93aea30e-86b2-44a9-aa80-d8fe0d3eb90d",
  'is_default': 1
};
Map<String, dynamic> addAddressSuccessBody = <String, dynamic>{
  'phone_number': "0522222222",
  'country_uuid': "countryUUID",
  'city_uuid': "cityUUID",
  'apartment': "apartment",
  'zip_code': "zipCode",
  'is_default': 1,
  'street_name': "street_name",
  'state': "state",
};

///------------ Failure Body ----------------///

///------------- success Response ----------------------///

Map<String, dynamic> getAddressSuccessResponse = <String, dynamic>{
  "status_code": 200,
  "code": 1022,
  "hint": "Process successfully",
  "success": true,
  "data": <String, dynamic>{
    "message": "address retrieved Successfully",
    "addresses": <Map<String, dynamic>>[
      <String, dynamic>{
        "uuid": "93aea30e-86b2-44a9-aa80-d8fe0d3eb90d",
        "user_uuid": "8a67612b-a3ad-4c21-9b12-38b0342c1e1d",
        "street_name": "1600 Amphitheatre Pkwy",
        "state": "Mountain View",
        "apartment": "1600",
        "zip_code": "94043",
        "country": "3c8e2d3a-77f1-3a97-ade8-fa90205f2315",
        "city": "d2896cdb-9792-3855-96ed-9039cc9358a5",
        "status": true,
        "is_default": true
      }
    ]
  }
};

Map<String, dynamic> deleteAddressSuccessResponse = <String, dynamic>{
  "status_code": 200,
  "code": 1022,
  "hint": "Process successfully",
  "success": true,
  "data": <String, dynamic>{"message": "address Deleted Successfully"}
};

Map<String, dynamic> updateAddressSuccessResponse = <String, dynamic>{
  "status_code": 200,
  "code": 1022,
  "hint": "Process successfully",
  "success": true,
  "data": <String, dynamic>{
    "message": "address Updated Successfully",
    "address": <String, dynamic>{
      "uuid": "ca83adf3-608d-43cd-81d0-63869ee4ff24",
      "user_uuid": "8a67612b-a3ad-4c21-9b12-38b0342c1e1d",
      "street_name": "Al-homosani",
      "state": "Zayton",
      "apartment": "50",
      "zip_code": "115111",
      "country": "3ad73528-60fa-453d-b683-b04eb6fb820a",
      "city": "07996e3c-e4db-4e66-a88d-2e21c82caead",
      "status": true,
      "is_default": true
    }
  }
};

Map<String, dynamic> addAddressSuccessResponse = <String, dynamic>{
  "status_code": 201,
  "code": 1021,
  "hint": "Resource created successfully",
  "success": true,
  "data": <String, dynamic>{
    "message": "address created  Successfully",
    "address": <String, dynamic>{
      "uuid": "69261dc4-7bf4-4a90-8486-bb5697810f27",
      "user_uuid": "8a67612b-a3ad-4c21-9b12-38b0342c1e1d",
      "street_name": "Al-homosani",
      "state": "Zayton",
      "apartment": "50",
      "zip_code": "115111",
      "country": "3ad73528-60fa-453d-b683-b04eb6fb820a",
      "city": "07996e3c-e4db-4e66-a88d-2e21c82caead",
      "status": true,
      "is_default": true
    }
  }
};

///--------------- Failed Response ---------------//////

Map<String, dynamic> toggleFailedResponse = <String, dynamic>{
  "status_code": 404,
  "code": 1044,
  "hint": "Resource not found",
  "success": false,
  "errors": <String, dynamic>{"error": "The wallet does not exist!"}
};

Map<String, dynamic> withdrawDepositFailedResponse = <String, dynamic>{
  "status_code": 422,
  "success": false,
  "code": 1422,
  "hint": "Unprocessable Entity",
  "errors": <String, dynamic>{
    "amount": <String>["The amount must be greater than or equal to 0."]
  }
};

///--------------- Values ---------------//////
ValueClass getAddressesValues = ValueClass(
  successfulResponse: getAddressSuccessResponse,
  path: getAddressesPath,
  failureResponse: <String, dynamic>{},
);
ValueClass deleteAddressesValues = ValueClass(
  successfulResponse: deleteAddressSuccessResponse,
  path: deleteAddressesPath,
  successfulBody: FormData.fromMap(deleteAddressSuccessBody),
  failureResponse: <String, dynamic>{},
);
ValueClass updateAddressValues = ValueClass(
  successfulResponse: updateAddressSuccessResponse,
  path: updateAddressesPath,
  successfulBody: FormData.fromMap(updateAddressSuccessBody),
  failureResponse: <String, dynamic>{},
);

ValueClass addAddressValues = ValueClass(
  successfulResponse: addAddressSuccessResponse,
  path: addAddressesPath,
  successfulBody: FormData.fromMap(addAddressSuccessBody),
  failureResponse: <String, dynamic>{},
);
