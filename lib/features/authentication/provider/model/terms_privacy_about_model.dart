import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';

class TermPrivacyAboutModel extends ParentModel {
  String? title;
  String? description;
  bool? isExpanded;

  TermPrivacyAboutModel({
    this.title,
    this.description,
    this.isExpanded = false,
  });

  @override
  TermPrivacyAboutModel fromJsonInstance(Map<String, dynamic> json) {
    final FromMap converter = FromMap(map: json);
    final TermPrivacyAboutModel termPrivacyModel = TermPrivacyAboutModel(
        title: converter.convertToString(key: 'message'),
        description:converter.convertToString(key:  json['about_us'] == null
            ? (json['terms'] == null ? 'privacy' : 'terms')
            : 'about_us'));

    return termPrivacyModel;
  }
}
