import 'package:queen_validators/queen_validators.dart';
import 'package:res_pay_merchant/core/widget/text_field/validator/parent/parent_validator.dart';

class ExpireDateValidator extends ParentValidator {
  String? Function(String? p1)? validation() {
    return qValidator(
      <TextValidationRule>[IsRequired(''), MaxLength(7, ''), MinLength(7, '')],
    );
  }
}
