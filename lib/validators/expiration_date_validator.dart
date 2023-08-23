import 'package:payment_card_form/shared/shared.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ExpirationDateValidator extends Validator<dynamic> {
  const ExpirationDateValidator() : super();

  @override
  Map<String, dynamic>? validate(AbstractControl control) {
    final value = control.value as String?;

    if (control.isNull || (value != null && value.isEmpty)) {
      return {'required': true};
    }

    if (value!.length < 5) return {'minLength': true};

    final DateTime now = DateTime.now();
    final List<String> date = value.split(RegExp(r'/'));
    final int month = int.parse(date.first);
    final cardDate = DatetimeConverter.fromShortString(value);

    if (cardDate.isBefore(now) || month > 12 || month == 0) {
      return {'invalid': true};
    }

    return null;
  }
}
