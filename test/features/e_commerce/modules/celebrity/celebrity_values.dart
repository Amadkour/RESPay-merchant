import 'package:dio/dio.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/api/end_points.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/model/celebrities_model.dart';

import '../../../../core/abstract_values.dart';

///------------- success getPromotionsSuccessResponse ----------------------///

Map<String, dynamic> getCelebritiesSuccessResponse = <String, dynamic>{
  "status_code": 200,
  "code": 1022,
  "hint": "Process successfully",
  "success": true,
  "data": <String, dynamic>{
    "celebrities": <dynamic>[
      <String, dynamic>{
        "uuid": "a7db9bd9-fb48-3cc9-8049-512da4b839b0",
        "product_count": 2,
        "full_name": "Messi",
        "image":
            "https://cdn.eightyythree.com/public/uploads/authentication/IMG_0748.webp"
      },
      <String, dynamic>{
        "uuid": "a7db9bd9-fb48-3cc9-8049-512da4b839b1",
        "product_count": 0,
        "full_name": "Amr Diab",
        "image":
            "https://cdn.eightyythree.com/public/uploads/authentication/IMG_0746.webp"
      },
      <String, dynamic>{
        "uuid": "a7db9bd9-fb48-3cc9-8049-512da4b839b2",
        "product_count": 1,
        "full_name": "C.Ronaldo",
        "image":
            "https://cdn.eightyythree.com/public/uploads/authentication/IMG_0747.webp"
      },
      <String, dynamic>{
        "uuid": "a7db9bd9-fb48-3cc9-8049-512da4b839b4",
        "product_count": 2,
        "full_name": "Celebrity-4",
        "image":
            "https://cdn.eightyythree.com/public/uploads/authentication/IMG_0747.webp"
      }
    ]
  }
};

Map<String, dynamic> getSingleCelebritySuccessResponse = <String, dynamic>{
  "status_code": 200,
  "code": 1022,
  "hint": "Process successfully",
  "success": true,
  "data": <String, dynamic>{
    "celebrity": <String, dynamic>{
      "uuid": "a7db9bd9-fb48-3cc9-8049-512da4b839b0",
      "full_name": "Messi",
      "image":
          "https://cdn.eightyythree.com/public/uploads/authentication/IMG_0748.webp"
    },
    "product_count": 5,
    "products": <dynamic>[
      <String, dynamic>{
        "uuid": "8d54343e-171c-38ae-a11e-dc59c64b840b",
        "slug": "new-product-1",
        "name": "new product1",
        "price": 398,
        "sale_price": "0",
        "thumb_image":
            "https://cdn.eightyythree.com//public/uploads/products/2.webp",
        "is_favorite": false
      }
    ],
    "banners": <dynamic>[]
  }
};

///--------------- Failed getPromotionsResponseFail ---------------//////

Map<String, dynamic> getSingleShopResponseFail = <String, dynamic>{
  "status_code": 404,
  "code": 1044,
  "hint": "Resource not found",
  "success": false,
  "errors": <String, dynamic>{"error": "shop not found"}
};
Map<String, dynamic> getCelebritiesResponseFail = <String, dynamic>{
  "status_code": 404,
  "code": 1044,
  "hint": "Resource not found",
  "success": false,
  "errors": <String, dynamic>{"error": "error happen"}
};

Map<String, dynamic> getSingleCelebrityResponseFail = <String, dynamic>{
  "status_code": 404,
  "code": 1044,
  "hint": "Resource not found",
  "success": false,
  "errors": <String, dynamic>{"error": "error happen"}
};

///--------------- Values ---------------//////
ValueClass getCelebritiesValues = ValueClass(
  successfulResponse: getCelebritiesSuccessResponse,
  failureResponse: getCelebritiesResponseFail,
  successfulBody: FormData.fromMap(<String, dynamic>{}),
  failureBody: FormData.fromMap(<String, dynamic>{}),
  path: getListOfCelebrities,
);

///--------------- Values ---------------//////
ValueClass getSingleCelebrityValues = ValueClass(
  successfulResponse: getSingleCelebritySuccessResponse,
  failureResponse: getSingleCelebrityResponseFail,
  successfulBody: FormData.fromMap(<String, dynamic>{}),
  failureBody: FormData.fromMap(<String, dynamic>{}),
  path: getSingleCelebrityEndPoint,
);

CelebritiesModel celebrities = CelebritiesModel().fromJsonInstance(
        getCelebritiesSuccessResponse['data'] as Map<String, dynamic>)
    as CelebritiesModel;
