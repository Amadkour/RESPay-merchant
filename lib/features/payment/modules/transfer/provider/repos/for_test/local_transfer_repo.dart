import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/beneficary_model.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/transfer.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/repos/for_test/transfer_repo.dart';

class LocalTransferRepo extends TransferRepo {
  @override
  Future<List<ParentModel>> getBeneficiaries({bool? fromApi}) async {
    if (fromApi!) {
      final String response =
          await rootBundle.loadString('assets/jsons/beneficiaries.json');
      final List<dynamic> data = await json.decode(response) as List<dynamic>;
      return data
          .map((dynamic e) =>
              Beneficiary().fromJsonInstance(e as Map<String, dynamic>))
          .toList();
    } else {
      return <Beneficiary>[];
    }
  }

  @override
  Future<List<ParentModel>> getTransfersTypes() async {
    final String response =
        await rootBundle.loadString('assets/jsons/TransferTypes.json');
    final List<dynamic> data = await json.decode(response) as List<dynamic>;
    return data
        .map((dynamic e) =>
            Transfer().fromJsonInstance(e as Map<String, dynamic>))
        .toList();
  }
}
