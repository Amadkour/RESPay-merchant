import 'package:equatable/equatable.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/transfer_category.dart';

class TransferOptionsModel extends ParentModel with EquatableMixin {
  late List<String>? internalTransferTypes;
  late List<String>? externalTransferTypes;
  late List<String>? transferPurposes;
  late List<TransferCategoryModel>? transferCategories;
  late List<String>? walletNames;
  TransferOptionsModel(
      {this.internalTransferTypes,
      this.transferCategories,
      this.externalTransferTypes,
      this.transferPurposes,
      this.walletNames});

  @override
  TransferOptionsModel fromJsonInstance(Map<String, dynamic> json) {
    final Map<String, dynamic> transferTypes =
        json['transfer_types'] as Map<String, dynamic>;
    final FromMap converter = FromMap(map: json);
    return TransferOptionsModel(
      externalTransferTypes:
          converter.convertToListOFString(transferTypes['external']),
      internalTransferTypes:
          converter.convertToListOFString(transferTypes['internal']),
      transferPurposes: converter.convertToListOFString(json['purposes']),
      transferCategories: (json["categories"] as List<dynamic>)
          .map((dynamic e) => const TransferCategoryModel()
              .fromJsonInstance(e as Map<String, dynamic>))
          .toList(),
      walletNames: converter.convertToListOFString(json['wallet_names']),
    );
  }

  void reset() {
    internalTransferTypes = null;
    externalTransferTypes = null;
    transferCategories = null;
    transferPurposes = null;
    walletNames = null;
  }

  @override
  List<Object?> get props => <Object?>[
        internalTransferTypes,
        externalTransferTypes,
        transferCategories,
        transferPurposes,
        walletNames,
      ];
}
