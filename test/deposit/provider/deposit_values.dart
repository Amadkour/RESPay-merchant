// ignore_for_file: always_specify_types


import 'package:res_pay_merchant/features/payment/modules/deposit/provider/end_points.dart';
import 'package:res_pay_merchant/features/payment/modules/deposit/provider/model/create_deposit_input.dart';
import 'package:res_pay_merchant/features/payment/modules/history/provider/model/wallet.dart';

import '../../cards/provider/card_values.dart';
import '../../core/abstract_values.dart';
import '../../history/provider/history_values.dart';

final Map<String, dynamic> _depositSuccessResponse = {
  "status_code": 200,
  "code": 1020,
  "hint": "Processed successfully",
  "success": true,
  "data": {
    "message": "Deposit success from Credit Card with amount 5000",
    "deposit": {
      "wallet_uuid": "dce9a58b-fb5b-4155-bf8f-10ff3aeb3a7f",
      "amount": "5000",
      "uuid": "ca9a302f-3a27-4f83-9ec5-c4d13572a508",
      "type": "deposit",
      "method": "wallet",
      "status": "pending",
      "created_at": "2023-03-02T10:16:44.000000Z",
      "id": 183
    },
    "transaction": {
      "wallet_uuid": "dce9a58b-fb5b-4155-bf8f-10ff3aeb3a7f",
      "amount": "5000",
      "uuid": "ca9a302f-3a27-4f83-9ec5-c4d13572a508",
      "type": "deposit",
      "method": "wallet",
      "status": "pending",
      "created_at": "2023-03-02T10:16:44.000000Z",
      "id": 183
    }
  }
};

final Map<String, dynamic> _depositFailedResponse = <String, dynamic>{
  "status_code": 422,
  "success": false,
  "code": 1422,
  "hint": "Unprocessable Entity",
  "errors": <String, dynamic>{
    "wallet_uuid": <String>["The wallet uuid field is required."]
  }
};

final CreateDepositInput makeDepositParams = CreateDepositInput(
  walletUUID: (wallet as Wallet).uuid,
  cardUUID: cardModel.uuid,
  type: "credit_card",
  amount: "500",
);

final ValueClass depositValues = ValueClass(
  path: createDepositEndPoint,
  successfulResponse: _depositSuccessResponse,
  failureResponse: _depositFailedResponse,
  successfulBody: makeDepositParams.toMap(),
);
