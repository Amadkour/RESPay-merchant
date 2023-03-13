import 'package:queen_validators/queen_validators.dart';
import 'package:res_pay_merchant/core/widget/text_field/validator/parent/parent_validator.dart';

class NameValidator extends ParentValidator {
  @override
  String? Function(String?)? getValidation() {
    return qValidator(
       <TextValidationRule>[
        IsRequired(
          errorMessage('name_empty'),
        ),
      ],
    );
  }
}
