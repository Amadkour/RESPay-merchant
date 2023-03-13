import 'package:dio/dio.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/favourite/provider/api/end_points.dart';

import '../core/abstract_values.dart';

///------------- success getPromotionsSuccessResponse ----------------------///

Map<String, dynamic> getFavouritesSuccessResponse = <String, dynamic>{
  "status_code": 200,
  "code": 1022,
  "hint": "Process successfully",
  "success": true,
  "data": <String,dynamic>{
    "message": "Favorites List",
    "favorites": <String,dynamic>{
      "id": 7,
      "uuid": "d2c679a3-1289-4607-9f4d-266b51db0b97",
      "user_uuid": "8a67612b-a3ad-4c21-9b12-38b0342c1e1d",
      "items": <Map<String,dynamic>>[
        <String,dynamic>{
          "uuid": "85d59540-bbd4-32b8-b4b2-dd969e6a0fd3",
          "slug": "new-product-3",
          "name": "new product3",
          "description": "Possimus numquam non ea necessitatibus maiores rem quia distinctio. Est dolores adipisci voluptatibus illum nobis. Voluptatem at ea ex eligendi omnis enim. Harum veniam dolore alias.",
          "price": 495,
          "offer_price": null,
          "is_published": "1",
          "image": <String>[]
        }
      ]
    }
  }
};
Map<String, dynamic> addToFavouriteSuccessResponse = <String, dynamic>{
  "status_code": 201,
  "code": 1021,
  "hint": "Resource created successfully",
  "success": true,
  "data": <String,dynamic>{
    "message": "Product has been added successfully!",
    "favorites_count": 2
  }
};

Map<String, dynamic> removeFromFavouriteSuccessResponse = <String, dynamic>{
  "status_code": 200,
  "code": 1022,
  "hint": "Process successfully",
  "success": true,
  "data": <String,dynamic>{
    "message": "Product has been removed successfully!"
  }
};

Map<String, dynamic> addToFavouriteFailureResponse = <String, dynamic>{
  "status_code": 400,
  "code": 1032,
  "hint": "Product In Favorites",
  "success": false,
  "errors": <String,dynamic>{
    "error": "Product already exist in favorites!"
  }
};

Map<String, dynamic> removeFromFavouriteFailureResponse = <String, dynamic>{
  "status_code": 404,
  "code": 1044,
  "hint": "Resource not found",
  "success": false,
  "errors": <String,dynamic>{
    "error": "This product not found in your favorites!"
  }
};

///--------------- Failed getPromotionsResponseFail ---------------//////

Map<String, dynamic> getFavouritesResponseFail = <String, dynamic>{
  "status_code": 422,
  "code": 1422,
  "hint": "Unprocessable Entity",
  "errors": <String,dynamic>{
    "user_uuid": <String>[
      "The user uuid field is required."
    ]
  },
  "success": false
};

///--------------- Values ---------------//////
ValueClass getFavouritesValues = ValueClass(
  successfulResponse: getFavouritesSuccessResponse,
  failureResponse: getFavouritesResponseFail,
  successfulBody: FormData.fromMap(<String,dynamic>{}),
  failureBody: FormData.fromMap(<String,dynamic>{}),
  path: getFavouriteProductsEndPoint,
);

///--------------- Values ---------------//////
ValueClass addToFavouritesValues = ValueClass(
  successfulResponse: addToFavouriteSuccessResponse,
  failureResponse: addToFavouriteFailureResponse,
  successfulBody: FormData.fromMap(<String,dynamic>{
    "product_uuid":"85d59540-bbd4-32b8-b4b2-dd969e6a0fd3",
  }),
  failureBody: FormData.fromMap(<String,dynamic>{
    "product_uuid":"22d59540-bbd4-32b8-b4b2-11969e6a0fd3",
  }),
  path: addToFavouriteEndPoint,
);

///--------------- Values ---------------//////
ValueClass removeFromFavouritesValues = ValueClass(
  successfulResponse: removeFromFavouriteSuccessResponse,
  failureResponse: removeFromFavouriteFailureResponse,
  successfulBody: FormData.fromMap(<String,dynamic>{
    "favorite_uuid":"d2c679a3-1289-4607-9f4d-266b51db0b97",
    "product_uuid":"85d59540-bbd4-32b8-b4b2-dd969e6a0fd3"
  }),
  failureBody: FormData.fromMap(<String,dynamic>{
    "favorite_uuid":"d2c679a3-1289-4607-9f4d-266b51db0b97",
    "product_uuid":"22d59540-bbd4-32b8-b4b2-11969e6a0fd3"
  }),
  path: deleteFavouriteProductsEndPoint,
);
