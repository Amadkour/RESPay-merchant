import 'package:queen_validators/queen_validators.dart';
import 'package:res_pay_merchant/core/widget/text_field/validator/parent/parent_validator.dart';

class AccountNumberValidator extends ParentValidator {

  String? Function(String? p1)?  validation() {
    return qValidator(
      <TextValidationRule>[
        IsRequired(
          errorMessage('account_number_empty'),
        ),
        MinLength(
          18,
          errorMessage('account_number_lower'),
        ),
        MaxLength(
          30,
          errorMessage('account_number_greater'),
        ),
      ],
    );
  }
}
