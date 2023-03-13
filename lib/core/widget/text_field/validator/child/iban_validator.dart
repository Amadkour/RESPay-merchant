import 'package:queen_validators/queen_validators.dart';
import 'package:res_pay_merchant/core/widget/text_field/validator/parent/parent_validator.dart';

class IbanValidator extends ParentValidator {
  int? maxLength;
  IbanValidator({this.maxLength});
  String? Function(String?)? validation() {
    return qValidator(
      <TextValidationRule> [
        IsRequired(
          errorMessage('IBAN_empty'),
        ),

        MaxLength(
          maxLength ?? 34,
          errorMessage('IBAN_greater', maxLength: maxLength.toString()),
        ),
        MinLength(
          24,
          errorMessage('IBAN_lower', maxLength: 24.toString()),
        ),
      ],
    );
  }
}
