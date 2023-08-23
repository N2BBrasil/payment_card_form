import 'package:payment_card_form/shared/shared.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CPFValidator extends Validator<dynamic> {
  const CPFValidator() : super();

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    if (control.isNull) {
      return {'required': true};
    }

    return (CpfUtils.isValid(control.value as String?)) ? null : {'cpf': true};
  }
}
