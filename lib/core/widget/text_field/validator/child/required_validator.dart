import 'package:queen_validators/queen_validators.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/widget/text_field/validator/parent/parent_validator.dart';

class RequiredValidation extends ParentValidator {
  @override
  String? Function(String? p1)? getValidationWithLength(
      {int? minLength, int? maxLength}) {
    return qValidator(<TextValidationRule>[
      if (maxLength != null)
        MaxLength(
          maxLength,
          errorMessage("must not be greater than $maxLength characters."),
        ),
      if (minLength != null)
        MinLength(minLength,
            errorMessage("${tr("at least")} $minLength ${tr("characters")}")),
    ]);
  }
}
