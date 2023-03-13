import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';

class TrackingStageModel {
  final String status;
  final DateTime date;

  final String? descriptionEn;
  final String? descriptionAr;
  TrackingStageModel({
    required this.status,
    required this.date,
    this.descriptionEn,
    this.descriptionAr,
  });

  String get description => (isArabic && descriptionAr != null ? descriptionAr : descriptionEn) ?? "";
  factory TrackingStageModel.fromMap(Map<String, dynamic> map) {
    return TrackingStageModel(
      status: map['status'] as String,
      date: DateTime.parse(map['created_at'] as String),
      descriptionAr: (map['description'] as Map<String, dynamic>)['ar'] as String?,
      descriptionEn: (map['description'] as Map<String, dynamic>)['en'] as String?,
    );
  }
}
