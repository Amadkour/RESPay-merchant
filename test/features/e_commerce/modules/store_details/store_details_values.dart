import 'package:dio/dio.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/store_details/provider/api/end_points.dart';

import '../../../../core/abstract_values.dart';


///------------- success getPromotionsSuccessResponse ----------------------///

Map<String, dynamic> getSingleShopSuccessResponse = <String, dynamic>{
  "status_code": 200,
  "code": 1022,
  "hint": "Process successfully",
  "success": true,
  "data": <String,dynamic>{
    "message": "shop retrieved Successfully",
    "shop": <String,dynamic>{
      "id": 1,
      "uuid": "d565de1a-ac52-31c9-b488-8c4d746b8f38",
      "user_uuid": "a7db9bd9-fb48-3cc9-8049-512da4b839a3",
      "name": "Mrs. Kyla Weissnat III",
      "slug": "blanditiis-dolorem-consectetur-dolores",
      "description": "Atque porro voluptate consequatur laboriosam. Aut pariatur minima laboriosam animi sint suscipit magni. Asperiores alias nam aut dolorem sed voluptatem.",
      "icon": "https://cdn.eightyythree.com/public/uploads/shops/shop_0.webp",
      "shop_category_uuid": "b5664f92-e8fa-3b2f-9130-d4b0d8e71a1e",
      "products": <dynamic>[],
      "categories": <dynamic>[]
    }
  }
};

///--------------- Failed getPromotionsResponseFail ---------------//////

Map<String, dynamic> getSingleShopResponseFail = <String, dynamic>{
  "status_code": 404,
  "code": 1044,
  "hint": "Resource not found",
  "success": false,
  "errors": <String,dynamic>{
    "error": "shop not found"
  }
};
///--------------- Values ---------------//////
ValueClass getSingleShopInfoValues = ValueClass(
  successfulResponse: getSingleShopSuccessResponse,
  failureResponse: getSingleShopResponseFail,
  successfulBody: FormData.fromMap(<String,dynamic>{}),
  failureBody: FormData.fromMap(<String,dynamic>{}),
  path: singleShopEndPoint,
);
