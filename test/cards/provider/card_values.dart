import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/provider/API/end_points.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/provider/model/credit_card_model.dart';
import 'package:res_pay_merchant/features/payment/modules/add_card/api/model/create_card_input.dart';

import '../../core/abstract_values.dart';

///------------- get payment method success ----------------------///

Map<String, dynamic> getPaymentMethodSuccessResponse = <String, dynamic>{
  "status_code": 200,
  "code": 1022,
  "hint": "Process successfully",
  "success": true,
  "data": <String, dynamic>{
    "payment_methods": <dynamic>[
      <String, dynamic>{
        "uuid": "ae257afe-b2b2-3bd5-b803-90e3afa65772",
        "name": "Connie Grant V",
        "icon": "146cbe83-ad37-34dd-a698-2fde6ccd82cc.ico",
        "is_active": true,
        "is_default": true
      },
      <String, dynamic>{
        "uuid": "e419a056-73c1-3ad4-abf3-2c56c2dbbf41",
        "name": "Mr. Rylan Rolfson",
        "icon": "3a66dc22-fc67-3da3-b963-719f83018938.ico",
        "is_active": true,
        "is_default": true
      },
      <String, dynamic>{
        "uuid": "8dbdfcb0-ab8e-3958-947c-3ec7f44187bf",
        "name": "Luciano Toy",
        "icon": "3039fbd9-aed7-3484-82f1-f8f7a03d4bb8.ico",
        "is_active": true,
        "is_default": true
      },
      <String, dynamic>{
        "uuid": "894b4a83-89ea-3434-bef7-53fe6df154ec",
        "name": "Georgette Greenholt I",
        "icon": "40b9bdbd-c51a-30fd-950c-8539042ad4e3.ico",
        "is_active": true,
        "is_default": true
      },
      <String, dynamic>{
        "uuid": "9fc5707a-38bf-3aca-b93c-20a9d897b8d5",
        "name": "Estella Runte",
        "icon": "ea495916-b1c3-3362-b0a7-ca9b8249fdeb.ico",
        "is_active": true,
        "is_default": true
      }
    ]
  }
};

///--------------- get payment method failed ---------------//////

Map<String, dynamic> cardsFailedResponse = <String, dynamic>{
  "status_code": 500,
  "code": 1060,
  "hint": "server exception",
  "success": false,
  "errors": <String, String>{"error": "Server Exception"}
};

final ValueClass paymentMethodValues = ValueClass(
  path: getPaymentMethodsApi,
  successfulResponse: getPaymentMethodSuccessResponse,
  failureResponse: cardsFailedResponse,
);

///------------- get credit cards  ----------------------///

Map<String, dynamic> getCreditCardsSuccessResponse = <String, dynamic>{
  "status_code": 200,
  "code": 1022,
  "hint": "Process successfully",
  "success": true,
  "data": <String, dynamic>{
    "credit_cards": <dynamic>[
      <String, dynamic>{
        "id": 3,
        "uuid": "e77f98ab-8145-4646-9d14-3ddd7e779a1b",
        "user_uuid": "c4d55181-aecd-434a-9cc0-a0199f718613",
        "holder_name": "Fady Gebdy",
        "card_number": "5555555555554444",
        "expiry_date": "01/2025",
        "cvv": 111,
        "type": "MASTERCARD",
        "is_active": true
      }
    ]
  }
};

final ValueClass getCreditCardsMethodValues = ValueClass(
  path: gerCreditCards,
  successfulResponse: getCreditCardsSuccessResponse,
  failureResponse: cardsFailedResponse,
  successfulParams: <String, dynamic>{},
);

///-------- card  operation response-----//

Map<String, dynamic> cardOperationSuccessResponse = <String, dynamic>{
  "status_code": 200,
  "code": 1022,
  "hint": "Process successfully",
  "success": true,
  "data": <String, dynamic>{"message": "The created credit card!"}
};

Map<String, dynamic> cardOperationFailedResponse = <String, dynamic>{
  "status_code": 422,
  "code": 1422,
  "hint": "Unprocessable Entity",
  "errors": <String, dynamic>{
    "user_uuid": <dynamic>["The user uuid field is required."]
  },
  "success": false
};

final CreateCardInput addCardParams = CreateCardInput(
  methodUUId: "6232323232323",
  name: "hady mohamed",
  number: "55555555555554444",
  date: "01/2020",
  cvv: "123",
);

Map<String, dynamic> addCardSuccessBody = addCardParams.toMap();

Map<String, dynamic> addCardFailedBody = addCardParams.toMap();

final ValueClass addCreditCardValues = ValueClass(
  path: createCreditCardApi,
  successfulResponse: cardOperationSuccessResponse,
  failureResponse: cardOperationFailedResponse,
  successfulParams: addCardSuccessBody,
  failureParams: addCardFailedBody,
);

//------delete card-----//

final Map<String, dynamic> deleteCardSuccessParams = <String, dynamic>{
  "card_uuid": "12323232323",
};
final Map<String, dynamic> deleteCardFailedParams = <String, dynamic>{
  "card_uuid": "",
};
final ValueClass deleteCreditCardValues = ValueClass(
  path: deleteCreditCardApi,
  successfulResponse: cardOperationSuccessResponse,
  failureResponse: cardOperationFailedResponse,
  successfulParams: deleteCardSuccessParams,
  failureParams: deleteCardFailedParams,
);

final CreditCardModel cardModel = CreditCardModel.fromJson(
    ((getCreditCardsSuccessResponse['data']! as Map<String, dynamic>)['credit_cards'] as List<dynamic>).first
        as Map<String, dynamic>);
