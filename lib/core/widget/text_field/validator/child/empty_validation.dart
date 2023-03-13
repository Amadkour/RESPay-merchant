import 'package:queen_validators/queen_validators.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/widget/text_field/validator/parent/parent_validator.dart';

class EmptyValidator extends ParentValidator {
  final int? minLength;
  final String? minErrorMessage;
  EmptyValidator({this.minLength, this.minErrorMessage});
  @override
  String? Function(String?)? getValidationWithParameter(String key)  {
    return qValidator(
      <TextValidationRule>[
        IsRequired(
          errorMessage(key),
        ),
        if(minLength!=null)...<TextValidationRule>[
          MinLength(
            minLength!,
            errorMessage(minErrorMessage??"${tr("at least")} $minLength ${tr("letters")}"),
          ),
        ]

      ],
    );
  }

}
