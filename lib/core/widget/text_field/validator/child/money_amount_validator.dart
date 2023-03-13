import 'package:queen_validators/queen_validators.dart';
import 'package:res_pay_merchant/core/widget/text_field/validator/parent/parent_validator.dart';

class MoneyAmountValidator extends ParentValidator {
  @override
  String? Function(String?)? getValidation() {
    return qValidator(
      <TextValidationRule>[
        IsRequired(
          errorMessage('required_amount'),
        ),
      ],
    );
  }
}
