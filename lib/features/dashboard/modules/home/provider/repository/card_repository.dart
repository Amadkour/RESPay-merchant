import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/provider/model/home_card.dart';
import 'package:res_pay_merchant/features/payment/modules/history/provider/model/transaction_model.dart';

class CardRepository {
  Future<List<HomeCard>> getCards() async {
    final String response =
        await rootBundle.loadString('assets/jsons/home_cards.json');
    final List<dynamic> data = await json.decode(response) as List<dynamic>;
    return data
        .map((dynamic e) => HomeCard.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<TransactionModel>> getTransactions() async {
    final String response =
        await rootBundle.loadString('assets/jsons/home_transaction.json');
    final List<HomeCard> data = (json.decode(response)
        as Map<String, dynamic>)['transactions'] as List<HomeCard>;

    return data
        .map(
            (dynamic e) => TransactionModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
