//------- Get budget values-----//

// ignore_for_file: always_specify_types

import 'package:dio/dio.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/provider/end_point.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/provider/model/budget_category_model.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/provider/model/budget_list_model.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/provider/model/create_budget_category_input.dart';

import '../../core/abstract_values.dart';

final Map<String, dynamic> getBudgetSuccessResponse = <String, dynamic>{
  "status_code": 200,
  "code": 1020,
  "hint": "Processed successfully",
  "success": true,
  "data": {
    "total": 500,
    "chart": {"Jan": 500},
    "budgets": [
      {
        "uuid": "210056be-4dc7-40cf-8f4e-7527ab75a100",
        "user_uuid": "4a19211b-5380-4821-b0ce-b3d06b6cb43f",
        "name": "Bills",
        "amount": 500,
        "spent": 2,
        "remaining": 498,
        "percent": 0.4,
        "is_active": false,
        "type": {
          "id": 1,
          "uuid": "b20b6c6f-e28b-4ef0-a801-ed5ed01d0f3d",
          "slug": "bills",
          "name": "Bills",
          "icon": "http://localhost/storage/uploads/categories/bills.svg"
        },
      }
    ],
    "categories": [
      {
        "id": 1,
        "uuid": "b20b6c6f-e28b-4ef0-a801-ed5ed01d0f3d",
        "slug": "bills",
        "name": "Bills",
        "icon": "http://localhost/storage/uploads/categories/bills.svg"
      },
      {
        "id": 2,
        "uuid": "d364dc4a-81da-40d5-bf65-1b6517ff73a6",
        "slug": "clothes",
        "name": "Clothes",
        "icon": "http://localhost/storage/uploads/categories/clothes.svg"
      },
      {
        "id": 3,
        "uuid": "acce91ae-7be8-465e-95e6-44750ade8997",
        "slug": "donation",
        "name": "Donation",
        "icon": "http://localhost/storage/uploads/categories/donation.svg"
      },
      {
        "id": 4,
        "uuid": "4b6605c2-f9a7-426d-996c-fb500812f1fb",
        "slug": "gasoline",
        "name": "Gasoline",
        "icon": "http://localhost/storage/uploads/categories/gasoline.svg"
      },
      {
        "id": 5,
        "uuid": "be986023-3ce6-487f-bc0d-db9558c461f6",
        "slug": "internet",
        "name": "Internet",
        "icon": "http://localhost/storage/uploads/categories/internet.svg"
      },
      {
        "id": 6,
        "uuid": "3d23e6eb-0e88-4799-9611-da64668a3b22",
        "slug": "investment",
        "name": "Investment",
        "icon": "http://localhost/storage/uploads/categories/investment.svg"
      },
      {
        "id": 7,
        "uuid": "4b381aa3-ad9c-4f44-8bb0-c40bd1d5b811",
        "slug": "restaurant-and-drink",
        "name": "Restaurant and Drink",
        "icon":
            "http://localhost/storage/uploads/categories/resturant_and_drink.svg"
      },
      {
        "id": 8,
        "uuid": "4e0e2415-93de-4e83-9c79-ca5e70096058",
        "slug": "shop",
        "name": "Shop",
        "icon": "http://localhost/storage/uploads/categories/shop.svg"
      },
      {
        "id": 9,
        "uuid": "60d47541-8e0e-48e6-b47e-7b68dc5cb7bb",
        "slug": "supermarket",
        "name": "Supermarket",
        "icon": "http://localhost/storage/uploads/categories/supermarket.svg"
      },
      {
        "id": 10,
        "uuid": "967a4fcd-f8d3-49d8-a702-803b9ce1009f",
        "slug": "pharmacy",
        "name": "Pharmacy",
        "icon": "http://localhost/storage/uploads/categories/pharmacy.svg"
      },
      {
        "id": 11,
        "uuid": "0284780e-a3b9-464c-94f4-e8a014b04aa4",
        "slug": "other-budget",
        "name": "Other Budget",
        "icon": "http://localhost/storage/uploads/categories/other_budget.svg"
      }
    ]
  }
};

final Map<String, dynamic> getBudgetWithMissingFieldResponse =
    <String, dynamic>{
  "status_code": 200,
  "code": 1020,
  "hint": "Processed successfully",
  "success": true,
  "data": {
    "total": 500,
    "chart": {"Jan": 500},
    "categories": [
      {
        "id": 1,
        "uuid": "b20b6c6f-e28b-4ef0-a801-ed5ed01d0f3d",
        "slug": "bills",
        "name": "Bills",
        "icon": "http://localhost/storage/uploads/categories/bills.svg"
      },
      {
        "id": 2,
        "uuid": "d364dc4a-81da-40d5-bf65-1b6517ff73a6",
        "slug": "clothes",
        "name": "Clothes",
        "icon": "http://localhost/storage/uploads/categories/clothes.svg"
      },
      {
        "id": 3,
        "uuid": "acce91ae-7be8-465e-95e6-44750ade8997",
        "slug": "donation",
        "name": "Donation",
        "icon": "http://localhost/storage/uploads/categories/donation.svg"
      },
      {
        "id": 4,
        "uuid": "4b6605c2-f9a7-426d-996c-fb500812f1fb",
        "slug": "gasoline",
        "name": "Gasoline",
        "icon": "http://localhost/storage/uploads/categories/gasoline.svg"
      },
      {
        "id": 5,
        "uuid": "be986023-3ce6-487f-bc0d-db9558c461f6",
        "slug": "internet",
        "name": "Internet",
        "icon": "http://localhost/storage/uploads/categories/internet.svg"
      },
      {
        "id": 6,
        "uuid": "3d23e6eb-0e88-4799-9611-da64668a3b22",
        "slug": "investment",
        "name": "Investment",
        "icon": "http://localhost/storage/uploads/categories/investment.svg"
      },
      {
        "id": 7,
        "uuid": "4b381aa3-ad9c-4f44-8bb0-c40bd1d5b811",
        "slug": "restaurant-and-drink",
        "name": "Restaurant and Drink",
        "icon":
            "http://localhost/storage/uploads/categories/resturant_and_drink.svg"
      },
      {
        "id": 8,
        "uuid": "4e0e2415-93de-4e83-9c79-ca5e70096058",
        "slug": "shop",
        "name": "Shop",
        "icon": "http://localhost/storage/uploads/categories/shop.svg"
      },
      {
        "id": 9,
        "uuid": "60d47541-8e0e-48e6-b47e-7b68dc5cb7bb",
        "slug": "supermarket",
        "name": "Supermarket",
        "icon": "http://localhost/storage/uploads/categories/supermarket.svg"
      },
      {
        "id": 10,
        "uuid": "967a4fcd-f8d3-49d8-a702-803b9ce1009f",
        "slug": "pharmacy",
        "name": "Pharmacy",
        "icon": "http://localhost/storage/uploads/categories/pharmacy.svg"
      },
      {
        "id": 11,
        "uuid": "0284780e-a3b9-464c-94f4-e8a014b04aa4",
        "slug": "other-budget",
        "name": "Other Budget",
        "icon": "http://localhost/storage/uploads/categories/other_budget.svg"
      }
    ]
  }
};
final Map<String, dynamic> budgetErrorResponse = {
  "status_code": 422,
  "code": 1422,
  "hint": "Unprocessable Entity",
  "success": false,
  "errors": {
    "user_uuid": ["The user uuid field is required."]
  }
};

final getBudgetValues = ValueClass(
    path: getBudgetApi,
    successfulResponse: getBudgetSuccessResponse,
    failureResponse: budgetErrorResponse,
    successfulParams: {
      "filter": "monthly",
    });

final addBudgetSuccessResponse = {
  "status_code": 201,
  "code": 1021,
  "hint": "Resource created successfully",
  "success": true,
  "data": {
    "message": "Budget Created Successfully",
    "budget": {
      "uuid": "2db00a62-6130-4f45-9145-f36cad801d91",
      "user_uuid": "4a19211b-5380-4821-b0ce-b3d06b6cb43f",
      "name": "Donation",
      "amount": 500,
      "spent": 0,
      "remaining": 500,
      "percent": 0,
      "is_active": false,
    }
  }
};

CreateBudgetCategoryInput addBudgetSuccessBody = CreateBudgetCategoryInput(
  budget: "500",
  parentCategoryUuid: "test",
);
final addBudgetCategoryValues = ValueClass(
  path: createBudgetCategoryApi,
  successfulResponse: addBudgetSuccessResponse,
  failureResponse: budgetErrorResponse,
  successfulBody: addBudgetSuccessBody.toMap(),
);

final deleteBudgetCategorySuccessResponse = {
  "status_code": 200,
  "code": 1020,
  "hint": "Processed successfully",
  "success": true,
  "data": {"message": "Budget Deleted Successfully"}
};
final deleteCardSuccessBody = FormData.fromMap({"uuid": "12345678"});
final deleteCardErrorBody = FormData.fromMap({"uuid": "1"});
final deleteBudgetCategoryValues = ValueClass(
  path: deleteBudgetCategoryApi,
  successfulResponse: deleteBudgetCategorySuccessResponse,
  failureResponse: budgetErrorResponse,
  successfulBody: deleteCardSuccessBody,
  failureBody: deleteCardErrorBody,
);

final updateBudgetSuccessResponse = {
  "status_code": 201,
  "code": 1021,
  "hint": "Resource created successfully",
  "success": true,
  "data": {
    "message": "Budget Created Successfully",
    "budget": {
      "uuid": "2db00a62-6130-4f45-9145-f36cad801d91",
      "user_uuid": "4a19211b-5380-4821-b0ce-b3d06b6cb43f",
      "name": "Donation",
      "amount": 500,
      "spent": 0,
      "remaining": 500,
      "percent": 0,
      "is_active": true,
    }
  }
};

CreateBudgetCategoryInput updateBudgetSuccessBody = CreateBudgetCategoryInput(
  budget: "500",
  parentCategoryUuid: "b20b6c6f-e28b-4ef0-a801-ed5ed01d0f3d",
  uuid: "210056be-4dc7-40cf-8f4e-7527ab75a100",
);
final updateBudgetCategoryValues = ValueClass(
  path: updateBudgetCategoryApi,
  successfulResponse: addBudgetSuccessResponse,
  failureResponse: budgetErrorResponse,
  successfulBody: addBudgetSuccessBody.toMap(),
);

final budgetParentModel = BudgetListModel().fromJsonInstance(
  getBudgetSuccessResponse['data'] as Map<String, dynamic>,
);

final budgetCategory = BudgetCategoryModel.fromMap(
  (addBudgetSuccessResponse['data']! as Map<String, dynamic>)['budget']
      as Map<String, dynamic>,
);
