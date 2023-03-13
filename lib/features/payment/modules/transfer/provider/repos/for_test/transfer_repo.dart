import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';

abstract class TransferRepo {
  Future<List<ParentModel>> getBeneficiaries({bool fromApi});
  Future<List<ParentModel>> getTransfersTypes();
}
