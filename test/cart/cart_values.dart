import 'package:dio/dio.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/provider/api/end_points.dart';

import '../core/abstract_values.dart';

///------------- success getPromotionsSuccessResponse ----------------------///

Map<String, dynamic> getCartSuccessResponse = <String, dynamic>{
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
Map<String, dynamic> addToCartSuccessResponse = <String, dynamic>{
  "status_code": 201,
  "code": 1021,
  "hint": "Resource created successfully",
  "success": true,
  "data": <String,dynamic>{
    "message": "Product has been added successfully!",
    "favorites_count": 2
  }
};

Map<String, dynamic> removeFromCartSuccessResponse = <String, dynamic>{
  "status_code": 200,
  "code": 1022,
  "hint": "Process successfully",
  "success": true,
  "data": <String,dynamic>{
    "message": "Product has been removed successfully!"
  }
};
Map<String, dynamic> updateProductInCartSuccessResponse = <String, dynamic>{
  "status_code": 201,
  "code": 1021,
  "hint": "Resource created successfully",
  "success": true,
  "data": <String,dynamic>{
    "message": "cart Updated Successfully",
    "cart": <String,dynamic>{
      "id": 3,
      "uuid": "b87fe811-121b-4ac0-bb02-0346754dcc1c",
      "user_uuid": "8a67612b-a3ad-4c21-9b12-38b0342c1e1d",
      "discount": 0,
      "shipping": 10,
      "sub_total": 2055,
      "tax": 308.25,
      "total": 2373.25,
      "items": <dynamic>[
        <String,dynamic>{
          "product_uuid": "3cc2d982-2a25-370b-bda2-557aa8f8dada",
          "uuid": "611e7be3-6187-4500-9c4d-75edb63ac2a1",
          "title": "new product4",
          "price": 411,
          "thumb_image": "https://cdn.eightyythree.com//public/uploads/products/5.webp",
          "variants": <dynamic>[],
          "quantity": "5"
        }
      ]
    }
  }
};

Map<String, dynamic> checkPromotionCodeSuccessResponse = <String, dynamic>{
  "status_code": 200,
  "code": 1022,
  "hint": "Process successfully",
  "success": true,
  "data": <String,dynamic>{
    "message": "Promo Code Added successfully!"
  }
};
Map<String, dynamic> removePromotionCodeSuccessResponse = <String, dynamic>{
  "status_code": 200,
  "code": 1022,
  "hint": "Process successfully",
  "success": true,
  "data": <String,dynamic>{
    "message": "Promo Code removed successfully!"
  }
};

Map<String, dynamic> addToCartFailureResponse = <String, dynamic>{
  "status_code": 400,
  "code": 1032,
  "hint": "Product In Favorites",
  "success": false,
  "errors": <String,dynamic>{
    "error": "Product already exist in favorites!"
  }
};

Map<String, dynamic> removeFromCartFailureResponse = <String, dynamic>{
  "status_code": 404,
  "code": 1044,
  "hint": "Resource not found",
  "success": false,
  "errors": <String,dynamic>{
    "error": "This product not found in your favorites!"
  }
};
Map<String, dynamic> updateProductInCartFailureResponse = <String, dynamic>{
  "status_code": 404,
  "code": 1044,
  "hint": "Resource not found",
  "success": false,
  "errors": <String,dynamic>{
    "error": "Item not found!"
  }
};
Map<String, dynamic> checkPromotionCodeFailureResponse = <String, dynamic>{
  "status_code": 404,
  "code": 1044,
  "hint": "Resource not found",
  "success": false,
  "errors": <String,dynamic>{
    "error": "Promo Code  not found!"
  }
};

Map<String, dynamic> removePromotionCodeFailureResponse = <String, dynamic>{
  "status_code": 404,
  "code": 1044,
  "hint": "Resource not found",
  "success": false,
  "errors": <String,dynamic>{
    "error": "Promo Code  not found!"
  }
};

///--------------- Failed getPromotionsResponseFail ---------------//////

Map<String, dynamic> getCartResponseFail = <String, dynamic>{
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
ValueClass getCartValues = ValueClass(
  successfulResponse: getCartSuccessResponse,
  failureResponse: getCartResponseFail,
  successfulBody: FormData.fromMap(<String,dynamic>{}),
  failureBody: FormData.fromMap(<String,dynamic>{}),
  path: getCartProductsEndPoint,
);

///--------------- Values ---------------//////
ValueClass addToCartValues = ValueClass(
  successfulResponse: addToCartSuccessResponse,
  failureResponse: addToCartFailureResponse,
  successfulBody: FormData.fromMap(<String,dynamic>{
    "product_uuid": "85d59540-777-32b8-b4b2-dd969e999fd1",
    "quantity": 1,
  }),
  failureBody: FormData.fromMap(<String,dynamic>{
    "product_uuid": "22d59540-bbd4-32b8-b4b2-11969e6a0fd3",
    "quantity": 1,
  }),
  path: addToCartEndPoint,
);

///--------------- Values ---------------//////
ValueClass removeFromCartValues = ValueClass(
  successfulResponse: removeFromCartSuccessResponse,
  failureResponse: removeFromCartFailureResponse,
  successfulBody: FormData.fromMap(<String,dynamic>{
    "item_uuid":"85d59540-7753-32b8-b4b2-dd939e6a0fd3",
  }),
  failureBody: FormData.fromMap(<String,dynamic>{
    "item_uuid":"85d59540-bbd4-32b8-b4b2-dd969e6a0fd3"
  }),
  path: deleteCartProductsEndPoint,
);

///--------------- Values ---------------//////
ValueClass updateProductsInCartValues = ValueClass(
  successfulResponse: updateProductInCartSuccessResponse,
  failureResponse: updateProductInCartFailureResponse,
  successfulBody: FormData.fromMap(<String,dynamic>{
    "item_uuid": "611e7be3-6187-4500-9c4d-75edb63ac2a1",
    "quantity": 2,
  }),
  failureBody: FormData.fromMap(<String,dynamic>{
    "item_uuid": "611e7be3-6187-4500-9c4d-75edb63ac2a2",
    "quantity": 1,
  }),
  path: updateCartProductsEndPoint,
);

///--------------- Values ---------------//////
ValueClass checkPromotionCodeValues = ValueClass(
  successfulResponse: checkPromotionCodeSuccessResponse,
  failureResponse: checkPromotionCodeFailureResponse,
  successfulBody: FormData.fromMap(<String,dynamic>{
    "code": "A56332434234h",
  }),
  failureBody: FormData.fromMap(<String,dynamic>{
    "code": "h56ww34434234a",
  }),
  path: checkPromotionEndPoint,
);

///--------------- Values ---------------//////
ValueClass removePromotionCodeValues = ValueClass(
  successfulResponse: removePromotionCodeSuccessResponse,
  failureResponse: removePromotionCodeFailureResponse,
  successfulBody: FormData.fromMap(<String,dynamic>{
    "code": "A56332434234h",
  }),
  failureBody: FormData.fromMap(<String,dynamic>{
    "code": "h56ww34434234a",
  }),
  path: removePromotionEndPoint,
);
