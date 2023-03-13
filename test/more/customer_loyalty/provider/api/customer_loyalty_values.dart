import 'package:dio/dio.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/customer_loyality/provider/end_point.dart';

import '../../../../core/abstract_values.dart';

///------------ Success Body ----------------///



///------------ Failure Body ----------------///
Map<String, dynamic> redeemFailureBody = <String, dynamic>{
  "shop_uuid": "8a67612b-a3ad-4c21-9b12-38b0342c1e1d"
};

///------------- success Response ----------------------///

Map<String, dynamic> getLoyaltiesSuccessResponse = <String, dynamic>{
  "status_code": 200,
  "code": 1022,
  "hint": "Process successfully",
  "success": true,
  "data": <String, dynamic>{
    "shops": <Map<String, dynamic>>[
      <String, dynamic>{
        "uuid": "b3f7b9e2-7f99-3c3d-88ea-e0075d1fd676",
        "name": "Carlee Kerluke DDS",
        "icon": "https://cdn.eightyythree.com/public/uploads/shops/shop_3.webp",
        "stars": 2
      },
      <String, dynamic>{
        "uuid": "d565de1a-ac52-31c9-b488-8c4d746b8f38",
        "name": "Mrs. Kyla Weissnat III",
        "icon": "https://cdn.eightyythree.com/public/uploads/shops/shop_0.webp",
        "stars": 0
      },
      <String, dynamic>{
        "uuid": "7770c98e-981f-3c6b-aa27-7f967296af7d",
        "name": "Javon Huels",
        "icon": "https://cdn.eightyythree.com/public/uploads/shops/shop_1.webp",
        "stars": 0
      },
      <String, dynamic>{
        "uuid": "71fca95c-b83a-3909-9b0d-eb5ed72608e0",
        "name": "Mrs. Breanne Kautzer",
        "icon": "https://cdn.eightyythree.com/public/uploads/shops/shop_2.webp",
        "stars": 0
      },
      <String, dynamic>{
        "uuid": "fa7e9ea1-322f-38cc-9844-fe3cdc03ef7e",
        "name": "Flo Daniel V",
        "icon": "https://cdn.eightyythree.com/public/uploads/shops/shop_4.webp",
        "stars": 0
      },
      <String, dynamic>{
        "uuid": "f64bb9d1-e6f0-4b28-822d-51c43af42e91",
        "name": "Addidas",
        "icon": "https://cdn.eightyythree.com/public/uploads/shops/images.webp",
        "stars": 0
      },
      <String, dynamic>{
        "uuid": "24eff471-bb6f-400d-aca5-d73c4f711b93",
        "name": "Carrefour",
        "icon":
            "https://cdn.eightyythree.com/public/uploads/shops/IMG_0731.webp",
        "stars": 0
      },
      <String, dynamic>{
        "uuid": "1adc9f25-9561-4e96-b6bc-da1a9ed6925d",
        "name": "Apple",
        "icon":
            "https://cdn.eightyythree.com/public/uploads/shops/IMG_0737.webp",
        "stars": 0
      },
      <String, dynamic>{
        "uuid": "fc121e17-a076-4752-aa29-bac51e8beb70",
        "name": "Egypt Laptop",
        "icon":
            "https://cdn.eightyythree.com/public/uploads/shops/IMG_0735.webp",
        "stars": 0
      }
    ]
  }
};

Map<String, dynamic> showLoyaltiesSuccessResponse = <String, dynamic>{
  "status_code": 200,
  "code": 1022,
  "hint": "Process successfully",
  "success": true,
  "data": <String, dynamic>{
    "shops": <String, dynamic>{
      "uuid": "fc121e17-a076-4752-aa29-bac51e8beb70",
      "name": "Egypt Laptop",
      "icon": "https://cdn.eightyythree.com/public/uploads/shops/IMG_0735.webp",
      "stars": 0,
      "description": "<p>Abc</p>"
    }
  }
};






///--------------- Failed Response ---------------//////



Map<String, dynamic> redeemFailedResponse = <String, dynamic>{

"status_code": 400,
"code": 1040,
"hint": "",
"success": false,
"errors": <String,dynamic>{
"error": "sorry! You're not complete the stamps"
}
};


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
ValueClass getLoyaltiesValues = ValueClass(
  successfulResponse: getLoyaltiesSuccessResponse,
  path: getCustomerLoyaltyListApi,
  failureResponse: <String, dynamic>{},
);
ValueClass showLoyaltiesValues = ValueClass(
  successfulResponse: showLoyaltiesSuccessResponse,
  path: showCustomerLoyaltyApi,
  failureResponse: <String, dynamic>{},
);
ValueClass redeemLoyaltiesValues = ValueClass(
  failureResponse: redeemFailedResponse,
  path: customerLoyaltyRedeemApi,
  successfulResponse: <String, dynamic>{},
  failureBody: FormData.fromMap(redeemFailureBody)
);
