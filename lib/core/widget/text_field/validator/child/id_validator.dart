import 'package:queen_validators/queen_validators.dart';

import 'package:res_pay_merchant/core/widget/text_field/validator/parent/parent_validator.dart';

class IDValidator extends ParentValidator {
  @override
  String? Function(String?)? getValidation() {
    return qValidator(
      <TextValidationRule>[
        IsRequired(
          errorMessage('id_empty'),
        ),
        MinLength(
          8,
          errorMessage('id_at_least'),
        ),
        MaxLength(10, errorMessage('id_greater'))
      ],
    );
  }
}
