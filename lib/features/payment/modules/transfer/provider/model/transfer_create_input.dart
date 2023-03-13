import 'package:dio/dio.dart';

class CreateTransferInput {
  final String amount;
  final String beneficiaryUUId;
  final String purpose;
  final String? category;
  final String? note;
  final String? userUUID;
  CreateTransferInput({
    this.category,
    this.note,
    this.userUUID,
    required this.amount,
    required this.beneficiaryUUId,
    required this.purpose,
  });

  FormData toMap() {
    return FormData.fromMap(<String, dynamic>{
      "amount": amount,
      "beneficiary_uuid": beneficiaryUUId,
      "purpose": purpose,
      "category": category,
      "note": note,
      "user_uuid": userUUID,
    });
  }
}
