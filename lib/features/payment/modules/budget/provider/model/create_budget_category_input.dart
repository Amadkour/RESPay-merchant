// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dio/dio.dart';

class CreateBudgetCategoryInput {

  late String? budget;
  late String? parentCategoryUuid;
  late String? uuid;
  FormData toMap() {
    return FormData.fromMap(
      <String, dynamic>{
        "uuid": uuid,
        'amount': budget,
        "category_uuid": parentCategoryUuid,
      },
    );
  }



  CreateBudgetCategoryInput({this.budget, this.parentCategoryUuid, this.uuid});
}
