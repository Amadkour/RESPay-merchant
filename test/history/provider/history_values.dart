// ignore_for_file: always_specify_types

import 'package:res_pay_merchant/features/payment/modules/history/provider/end_point.dart';
import 'package:res_pay_merchant/features/payment/modules/history/provider/model/history_filter_input.dart';
import 'package:res_pay_merchant/features/payment/modules/history/provider/model/item_transaction_list_model.dart';
import 'package:res_pay_merchant/features/payment/modules/history/provider/model/wallet.dart';

import '../../core/abstract_values.dart';

final Map<String, Object> _getWalletSuccessResponse = {
  "status_code": 200,
  "code": 1020,
  "hint": "Processed successfully",
  "success": true,
  "data": {
    "wallet": {
      "id": 18,
      "uuid": "84b79c0b-8af8-4088-bed8-874c421c94f3",
      "user_uuid": "c10de816-b528-4106-bbbf-91f73df12785",
      "total": 1000,
      "is_active": true,
      "is_normal": true,
      "is_saving": false,
      "transactions": [
        {
          "wallet_uuid": "84b79c0b-8af8-4088-bed8-874c421c94f3",
          "reference_number": "b7a935c4-8144-4c70-a95a-96f079fd3062",
          "amount": 1000,
          "type": "deposit",
          "method": "wallet",
          "status": "pending",
          "created_at": "2023-01-18T09:38:52.000000Z"
        }
      ]
    },
    "categories": [
      {
        "uuid": "78a5b771-4de2-49ee-b1b8-31167f9508c0",
        "title": "Buying Budget 1",
        "icon": "https://wallet.eightyythree.com/storage/uploads/categories/clothes.svg",
        "total_spent": 0
      }
    ]
  }
};

final _failureResponse = {
  "status_code": 422,
  "code": 1422,
  "hint": "Unprocessable Entity",
  "success": false,
  "errors": {
    "user_uuid": ["The user uuid field is required."]
  }
};

final getWalletValues = ValueClass(
  path: getWalletApi,
  successfulResponse: _getWalletSuccessResponse,
  failureResponse: _failureResponse,
);

final Map<String, Object> _getHistorySuccessResponse = {
  "status_code": 200,
  "code": 1020,
  "hint": "Processed successfully",
  "success": true,
  "data": {
    "transactions": {
      "Today": [
        {
          "wallet_uuid": "84b79c0b-8af8-4088-bed8-874c421c94f3",
          "reference_number": "b7a935c4-8144-4c70-a95a-96f079fd3062",
          "amount": 1000,
          "type": "deposit",
          "method": "wallet",
          "status": "pending",
          "created_at": "2023-01-18T09:38:52.000000Z"
        }
      ]
    },
    "transaction_types": {
      "deposit": "Deposit",
      "withdraw": "Withdraw",
      "transfer": "Transfer",
      "receive": "Receive",
      "buy": "Buy",
      "gift": "Gift",
      "Saving": "Saving",
      "Bill": "wallet.transaction_types.bill"
    },
    "period_types": {
      "Last week": "Last week",
      "Last 7 days": "Last 7 days",
      "Last Month": "Last Month",
      "Last Year": "Last Year"
    }
  }
};

final filterHistoryParams = HistoryPeriodFilterInput(
  from: "18/01/2023",
  period: "weekly",
  to: "19/01/2023",
);

final getHistoryValues = ValueClass(
  path: getTransactionListApi,
  successfulResponse: _getHistorySuccessResponse,
  failureResponse: _failureResponse,
  successfulParams: filterHistoryParams.toMap(),
);

final wallet = Wallet().fromJsonInstance(_getWalletSuccessResponse['data']! as Map<String, dynamic>);
final history = TransactionListModel().fromJsonInstance(_getHistorySuccessResponse['data']! as Map<String, dynamic>)
    as TransactionListModel;
