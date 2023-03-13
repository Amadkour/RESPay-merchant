import 'package:queen_validators/queen_validators.dart';
import 'package:res_pay_merchant/core/widget/text_field/validator/parent/parent_validator.dart';

class CreditCardValidator extends ParentValidator {
  String? Function(String? p1)? validation() {
    return qValidator(
      <TextValidationRule>[
        IsRequired(
          errorMessage('credit_card_required'),
        ),
        MinLength(
          19,
          errorMessage('credit_card_length_error'),
        ),
        MaxLength(
          19,
          errorMessage('credit_card_length_error'),
        ),
      ],
    );
  }
}
