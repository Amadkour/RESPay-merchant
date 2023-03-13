// ignore_for_file: always_specify_types

import 'package:res_pay_merchant/features/payment/modules/transfer/provider/api/end_point.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/transfer_create_input.dart';

import '../../core/abstract_values.dart';

final Map<String, Object> _makeTransferSuccessResponse = {
  "status_code": 200,
  "code": 1041,
  "hint": "success",
  "success": true,
};

final Map<String, dynamic> _failureResponse = {
  "status_code": 401,
  "code": 1041,
  "hint": "Unauthorized!",
  "success": false,
  "errors": {"error": "Unauthorized Access! Please check user token."}
};

final CreateTransferInput createTransferInput = CreateTransferInput(
  amount: '200',
  beneficiaryUUId: '123',
  purpose: "test",
);

final makeTransferValues = ValueClass(
  path: createTransferApi,
  successfulResponse: _makeTransferSuccessResponse,
  failureResponse: _failureResponse,
  successfulBody: createTransferInput.toMap(),
);

final _getTransferOptionsSuccess = {
  "status_code": 200,
  "code": 1020,
  "hint": "Processed successfully",
  "success": true,
  "data": {
    "transfer_types": {
      "internal": ["RES App", "Bank Account", "Mobile Wallet", "Gift"],
      "external": ["RES App", "Bank Account", "Mobile Wallet", "Western Union"]
    },
    "purposes": ["Family Expenses", "Salary", "Gift"],
    "categories": [],
    "wallet_names": ["OVO", "Fawry", "Vodafone Cash"]
  }
};

final getTransferOptionsValues = ValueClass(
  path: loadTransferOptions,
  successfulResponse: _getTransferOptionsSuccess,
  failureResponse: _failureResponse,
);
