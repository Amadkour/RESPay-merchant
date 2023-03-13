import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:res_pay_merchant/features/payment/modules/transaction_types/provider/model/transaction_type_model.dart';

class TransactionTypeRepository {
  Future<List<TransactionTypeModel>> getMoreData() async {
    final String response = await rootBundle
        .loadString('assets/jsons/more_bottomsheet/more_bottomsheet.json');
    final List<dynamic> data = await json.decode(response) as List<dynamic>;
    return data
        .map((dynamic e) =>
            TransactionTypeModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
