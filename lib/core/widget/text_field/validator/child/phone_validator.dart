import 'package:queen_validators/queen_validators.dart';
import 'package:res_pay_merchant/core/widget/text_field/validator/parent/parent_validator.dart';

class PhoneValidator extends ParentValidator {
  @override
  String? Function(String?)? getValidation() {
    return qValidator(
      <TextValidationRule>[
        IsRequired(
          errorMessage('phone_empty'),
        ),
        // StartsWith(
        //   '05',
        //   errorMessage('phone_greater'),
        // ),
        MinLength(
          10,
          errorMessage('phone_greater'),
        ),
        MaxLength(
          10,
          errorMessage('phone_greater'),
        ),
      ],
    );
  }
}
