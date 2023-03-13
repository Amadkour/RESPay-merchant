import 'package:dio/dio.dart';

class CreateCardInput {
  final String methodUUId;
  final String name;
  final String number;
  final String date;
  final String cvv;
  CreateCardInput({
    required this.methodUUId,
    required this.name,
    required this.number,
    required this.date,
    required this.cvv,
  });

  FormData toFormData() {
    return FormData.fromMap(toMap());
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{
      'payment_method_uuid': methodUUId,
      'holder_name': name,
      'card_number': number,
      'expiry': <String, dynamic>{
        "month": date.split("/").first,
        "year": date.split("/").last,
      },
      'cvv': cvv,
      "is_active": 1,
    };
    return map;
  }
}
