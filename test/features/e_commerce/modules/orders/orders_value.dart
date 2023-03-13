// ignore_for_file: always_specify_types

import 'package:dio/dio.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/end_point.dart';

import '../../../../core/abstract_values.dart';

final Map<String, dynamic> successOrderListResponse = {
  "status_code": 200,
  "code": 1022,
  "hint": "Process successfully",
  "success": true,
  "data": {
    "orders": [],
    "status": [
      "pending",
      "paid",
      "in-progress",
      "shipped",
      "delivered",
      "returned",
      "canceled"
    ]
  }
};

final Map<String, dynamic> successTrackOrderResponse = {
  "status_code": 200,
  "code": 1022,
  "hint": "Process successfully",
  "success": true,
  "data": {
    "order": {
      "uuid": "552d7f8f-21bb-4acb-b2d8-a1f504056dc6",
      "order_number": "ORD1677582410",
      "image": "https://cdn.eightyythree.com/public/uploads/product/IMG_0734.webp",
      "status": "pending",
      "estimated": "2023-03-05T11:09:41.081324Z",
      "address": {
        "id": 3,
        "uuid": "c36950bf-8fdd-428a-932f-bfd5b11873b4",
        "user_uuid": "7ab332c0-34a4-4fa6-a10f-ebe2b1365e60",
        "country_uuid": "af81318d-1ab8-3190-af46-465317776a35",
        "city_uuid": "c41e8c84-5f22-3f33-9cc3-9d7e01fa2d32",
        "phone_number": "0555505543",
        "is_default": "0",
        "status": "enabled",
        "created_at": "2023-02-28T11:06:41.000000Z",
        "updated_at": "2023-02-28T11:06:45.000000Z",
        "street_name": "1600 Amphitheatre Pkwy",
        "apartment": "1600",
        "state": "Mountain View",
        "zip_code": "94043",
        "deleted_at": null
      },
      "timeline": [
        {
          "id": 9,
          "uuid": "d9f6f006-4bb1-4740-bc88-712459806a91",
          "order_uuid": "552d7f8f-21bb-4acb-b2d8-a1f504056dc6",
          "status": "pending",
          "date": "2023-02-28 11:06:50",
          "description": {
            "en": "Order has been created"
          },
          "created_at": "2023-02-28T11:06:50.000000Z",
          "updated_at": "2023-02-28T11:06:50.000000Z",
          "deleted_at": null
        }
      ],
      "total": 31635,
      "items": [
        {
          "product_uuid": "2abf0d76-e8af-412f-bee6-68a0e84c99aa",
          "uuid": "6499d195-3391-467d-91c3-b8bd6c476f60",
          "title": 'HP Victus Gaming Laptop 16-d1052ne, 16.1" FHD, 12th Gen Intel Core i7, 16GB RAM, 512GB SSD, 4GB NVIDIA® GeForce RTX™ 3050 Ti Graphics, Windows 11 Home, En -Ar KB, Performance Blue - [7D7E9EA]',
          "price": 27500,
          "thumb_image": "https://cdn.eightyythree.com/public/uploads/product/IMG_0734.webp",
          "variants": [],
          "quantity": 1
        }
      ],
      "address_uuid": "c36950bf-8fdd-428a-932f-bfd5b11873b4",
      "user_uuid": "7ab332c0-34a4-4fa6-a10f-ebe2b1365e60",
      "payment_method": "wallet",
      "sub_total": 27500,
      "tax": 4125,
      "shipping": 10
    }
  }
};

final Map<String, dynamic> successBuyAgainResponse = {
  "status_code": 200,
  "code": 1022,
  "hint": "Process successfully",
  "success": true,
  "data": {
    "message": "cart Updated Successfully",
    "cart": {
      "uuid": "8d6a9951-df3a-42fd-8dc2-b6213a54d72d",
      "user_uuid": "7ab332c0-34a4-4fa6-a10f-ebe2b1365e60",
      "sub_total": 27500,
      "tax": 4125,
      "shipping": 10,
      "total": 31635,
      "items": [
        {
          "product_uuid": "2abf0d76-e8af-412f-bee6-68a0e84c99aa",
          "uuid": "6499d195-3391-467d-91c3-b8bd6c476f60",
          "title": 'HP Victus Gaming Laptop 16-d1052ne, 16.1" FHD, 12th Gen Intel Core i7, 16GB RAM, 512GB SSD, 4GB NVIDIA® GeForce RTX™ 3050 Ti Graphics, Windows 11 Home, En -Ar KB, Performance Blue - [7D7E9EA]',
          "price": 27500,
          "thumb_image": "https://cdn.eightyythree.com/public/uploads/product/IMG_0734.webp",
          "variants": [],
          "quantity": 1
        }
      ],
      "updated_at": "2023-02-28T11:29:05.000000Z",
      "created_at": "2023-02-28T11:29:05.000000Z",
      "id": 8
    }
  }
};

final Map<String, dynamic> successCancelOrderApiResponse = {
  "status_code": 200,
  "code": 1022,
  "hint": "Process successfully",
  "success": true,
  "data": {
    "message": "Order Canceled Successfully !"
  }
};

final failureOrderListFailureResponse = {
  "status_code": 404,
  "code": 1044,
  "hint": "Resource not found",
  "success": false,
  "errors": {
    "error": "Order Not Found"
  }
};

final failureCancelOrderFailureResponse = {
  "status_code": 404,
  "code": 1044,
  "hint": "Resource not found",
  "success": false,
  "errors": {
    "error": "Order Not Found"
  }
};

final failureTrackOrderFailureResponse = {
  "status_code": 404,
  "code": 1044,
  "hint": "Resource not found",
  "success": false,
  "errors": {
    "error": "Order Not Found"
  }
};

final failureBuyAgainFailureResponse = {
  "status_code": 404,
  "code": 1044,
  "hint": "Resource not found",
  "success": false,
  "errors": {
    "error": "Order Not Found"
  }
};

ValueClass getOrderValues = ValueClass(
  path: getOrderListApi,
  successfulResponse: successOrderListResponse,
  failureResponse: failureOrderListFailureResponse,
);

ValueClass trackOrderValues = ValueClass(
  path: trackOrderApi,

  successfulBody: FormData.fromMap(<String,dynamic>{
    "order_uuid":"ff342343433e"
  }),
  failureBody: FormData.fromMap(<String,dynamic>{
    "order_uuid":"ff34234343355555"
  }),

  successfulResponse: successTrackOrderResponse,
  failureResponse: failureTrackOrderFailureResponse,
);

ValueClass buyAgainValues = ValueClass(
  path: buyOrderAgain,
  successfulBody: FormData.fromMap(<String,dynamic>{
    "order_uuid":"552d7f8f-21bb-4acb-b2d8"
  }),
  failureBody: FormData.fromMap(<String,dynamic>{
    "order_uuid":"552d7f8f-21bb-4acb-b2d8-a1f504056dc6"
  }),
  successfulResponse: successBuyAgainResponse,
  failureResponse: failureBuyAgainFailureResponse,
);

ValueClass cancelOrderValues = ValueClass(
  path: cancelOrderApi,
  successfulBody: FormData.fromMap(<String,dynamic>{
    "order_uuid": "552d7f8f-21bb-4acb-b2d8-a1f504056dc6",
    //"user_uuid": loggedInUser.uuid,
    "description": "test",
  }),
  failureBody: FormData.fromMap(<String,dynamic>{
    "order_uuid": "552d7f8f-21bb-4a",
    //"user_uuid": loggedInUser.uuid,
    "description": "test",
  }),
  successfulResponse: successCancelOrderApiResponse,
  failureResponse: failureCancelOrderFailureResponse,
);

ValueClass complainOrderValues = ValueClass(
  path: complainOrderApi,
  successfulBody: FormData.fromMap(<String,dynamic>{
    'order_uuid': "orderUUID 1",
    'reason_type': "test 1",
    'description': 'description 1',
    'images[]': <String>[],
    "user_uuid": "dsweqggggd2e2343243dasd",
  }),
  failureBody: FormData.fromMap(<String,dynamic>{
    'order_uuid': "orderUUID 2",
    'reason_type': "test 2",
    'description': 'description 2',
    'images[]': <String>[],
    "user_uuid": "dsdsadd22343243dasd",
  }),
  successfulResponse: successCancelOrderApiResponse,
  failureResponse: failureCancelOrderFailureResponse,
);
