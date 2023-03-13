import 'package:dio/dio.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/provider/api/end_points.dart';

import '../../core/abstract_values.dart';

///------------- success getPromotionsSuccessResponse ----------------------///

Map<String, dynamic> getPromotionsSuccessResponse = <String, dynamic>{
  "status_code": 200,
  "code": 1022,
  "hint": "Process successfully",
  "success": true,
  "data": <String,dynamic>{
    "promotions": <dynamic>[
      <String,dynamic>{
        "shop_slug": "nam-veritatis-ut-praesentium-aut-officia",
        "shop_name": "Don Johnson",
        "shop_icon": "https://cdn.eightyythree.com/public/uploads/shops/shop_0.webp",
        "value": "All Item off 61.00 SAR",
        "valid_to": "Valid Till Mar 15, 2023",
        "code": "exWsttQ7fjQ",
        "offer_count": 4,
        "is_active": true
      },
      <String,dynamic>{
        "shop_slug": "perferendis-voluptas-explicabo-non-dolores-dolorem-minima",
        "shop_name": "Dr. Luther Jones",
        "shop_icon": "https://cdn.eightyythree.com/public/uploads/shops/shop_1.webp",
        "value": "All Item off 6.00 %",
        "valid_to": "Valid Till Mar 13, 2023",
        "code": "IrdeWqCGla3",
        "offer_count": 1,
        "is_active": true
      },
      <String,dynamic>{
        "shop_slug": "quo-error-facilis-aspernatur-ut",
        "shop_name": "Forrest Wiza Jr.",
        "shop_icon": "https://cdn.eightyythree.com/public/uploads/shops/shop_2.webp",
        "value": "All Item off 50.00 SAR",
        "valid_to": "Valid Till Mar 20, 2023",
        "code": "b4sdlEsQRZ1",
        "offer_count": 3,
        "is_active": true
      },
      <String,dynamic> {
        "shop_slug": "hic-odit-consequuntur-debitis-sit",
        "shop_name": "Dr. Kurtis Waters",
        "shop_icon": "https://cdn.eightyythree.com/public/uploads/shops/shop_3.webp",
        "value": "All Item off 71.00 SAR",
        "valid_to": "Valid Till Mar 3, 2023",
        "code": "QIHt4wPXqo6",
        "offer_count": 4,
        "is_active": true
      },
      <String,dynamic>{
        "shop_slug": "sed-at-dignissimos-qui-architecto-maxime-facere-aut",
        "shop_name": "Ms. Aubrey Maggio IV",
        "shop_icon": "https://cdn.eightyythree.com/public/uploads/shops/shop_4.webp",
        "value": "All Item off 18.00 %",
        "valid_to": "Valid Till Mar 25, 2023",
        "code": "rxyqXsjkOyE",
        "offer_count": 2,
        "is_active": true
      }
    ],
    "shops":<dynamic>[
      <String,dynamic>{
        "uuid": "f28905d7-3777-3ac2-9e6e-aa290cd49088",
        "name": "Don Johnson",
        "slug": "nam-veritatis-ut-praesentium-aut-officia"
      },
      <String,dynamic>{
        "uuid": "05a9ba1a-edbf-3e89-8a8b-29df30a714f7",
        "name": "Dr. Luther Jones",
        "slug": "perferendis-voluptas-explicabo-non-dolores-dolorem-minima"
      },
      <String,dynamic>{
        "uuid": "55b82b07-c85b-3a1e-9b31-89e6665e453d",
        "name": "Forrest Wiza Jr.",
        "slug": "quo-error-facilis-aspernatur-ut"
      },
      <String,dynamic>{
        "uuid": "3bb1af86-cb9a-394e-8d09-04e718022d49",
        "name": "Dr. Kurtis Waters",
        "slug": "hic-odit-consequuntur-debitis-sit"
      },
      <String,dynamic>{
        "uuid": "23a99993-fa6e-3893-9f66-4f6957b5e53c",
        "name": "Ms. Aubrey Maggio IV",
        "slug": "sed-at-dignissimos-qui-architecto-maxime-facere-aut"
      }
    ],
    "types": <dynamic>[
      "Latest",
      "10%-50%",
      "60%-100%"
    ],
    "shop_categories": <dynamic>[
      <String,dynamic>{
        "uuid": "f831077c-8dbc-3507-b562-1ea747d0f045",
        "name": "Miss Agnes Veum",
        "description": "Eaque culpa aliquam quia in. Ab ducimus ut ipsam reiciendis nemo. Quae sit qui quam.",
        "enabled": "enabled",
        "icon ": "https://cdn.eightyythree.com/public/uploads/shop_categories/shop_category_0.webp"
      },
      <String,dynamic>{
        "uuid": "4578e1b0-669f-38ee-84ef-1987acd51ab7",
        "name": "Prof. Julian Bergnaum",
        "description": "Repellat debitis odit nisi. A accusamus adipisci quia molestiae aut molestiae voluptates. Ratione debitis sed commodi sed.",
        "enabled": "enabled",
        "icon ": "https://cdn.eightyythree.com/public/uploads/shop_categories/shop_category_1.webp"
      },
      <String,dynamic>{
        "uuid": "d7e31786-1bc7-3635-ab85-43d01b1f6ef3",
        "name": "Katherine Denesik",
        "description": "Voluptatem voluptatum voluptatem architecto officia. Officia harum sapiente et et. Voluptatem corporis adipisci a veritatis pariatur ut et. Aut alias et minima incidunt corrupti vel eaque esse.",
        "enabled": "enabled",
        "icon ": "https://cdn.eightyythree.com/public/uploads/shop_categories/shop_category_2.webp"
      },
      <String,dynamic>{
        "uuid": "12571885-ca81-39ba-adcc-dac524115584",
        "name": "Clovis Waelchi",
        "description": "Dolore possimus pariatur non non fugit. Possimus fuga magni vel molestiae tempore. Consequatur ipsum consequuntur corrupti ipsam doloribus est illo. Aliquid porro cum recusandae molestias nam at.",
        "enabled": "enabled",
        "icon ": "https://cdn.eightyythree.com/public/uploads/shop_categories/shop_category_3.webp"
      },
      <String,dynamic>{
        "uuid": "e675fa0b-44ae-393e-b4e2-81e1c732bc48",
        "name": "Ethelyn Vandervort",
        "description": "Velit sed at voluptatem in nobis suscipit. Id quod eos quas beatae aspernatur. Dolores non mollitia consequuntur dolorem in qui expedita. Iste sunt est delectus repellendus.",
        "enabled": "enabled",
        "icon ": "https://cdn.eightyythree.com/public/uploads/shop_categories/shop_category_4.webp"
      }
    ]
  }
};

///--------------- Failed getPromotionsResponseFail ---------------//////

Map<String, dynamic> getPromotionsResponseFail = <String, dynamic>{
  "status_code":404,
  "code":1044,
  "hint":"Resource not found",
  "success":false,
  "errors":<String,dynamic>{"error":"server error"}
};

///--------------- Values ---------------//////
ValueClass getPromotionsValues = ValueClass(
  successfulResponse: getPromotionsSuccessResponse,
  failureResponse: getPromotionsResponseFail,
  successfulBody: FormData.fromMap(<String,dynamic>{}),
  failureBody: FormData.fromMap(<String,dynamic>{}),
  path: getPromotionsEndPoint,
);
