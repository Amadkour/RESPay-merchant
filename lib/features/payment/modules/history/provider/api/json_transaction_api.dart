// import 'dart:convert';

// import 'package:dartz/dartz.dart';
// import 'package:flutter/services.dart';
// import 'package:res_pay_merchant/core/errors/failures.dart';
// import 'package:res_pay_merchant/features/history/provider/api/base_transaction_api.dart';

// class JsonTransactionApi extends BaseTransactionApi {
//   @override
//   Future<Either<Failure, Response<Map<String, dynamic>>>> getWallet() async {
//     final String json = await rootBundle.loadString('assets/jsons/home_transaction.json');

//     return right(jsonDecode(json) as Map<String, dynamic>);
//   }

//   @override
//   Future<Either<Failure, Map<String, dynamic>>> getTransactions() {
//     // TODO: implement getTransactions
//     throw UnimplementedError();
//   }
// }
