// import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';
// import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
//
// class ReferralModel extends ParentModel{
//   ReferralModel({
//       String? refCode,
//       List<dynamic>? referrals,}){
//     _refCode = refCode;
//     _referrals = referrals;
// }
//
//   ReferralModel.fromJson(Map<String,dynamic> json) {
//     final FromMap converter = FromMap(map: json);
//
//     _refCode = converter.convertToString(key: 'ref_code');
//     if (json['referrals'] != null) {
//       _referrals = <dynamic>[];
//       json['referrals'].forEach((dynamic v) {
//         _referrals?.add(converter.convertToListOFString('referrals'));
//       });
//     }
//   }
//   @override
//   ParentModel fromJsonInstance(Map<String, dynamic> json) {
//   return ReferralModel(refCode: json['ref_code'] as String,referrals:json['referrals'] as List<dynamic> );
//   }
//
//   String? _refCode;
//   List<dynamic>? _referrals;
//
//   String? get refCode => _refCode;
//   List<dynamic>? get referrals => _referrals;
//
//
// }
