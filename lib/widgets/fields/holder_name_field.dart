import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payment_card_form/payment_card_form.dart';
import 'package:reactive_forms/reactive_forms.dart';

class HolderNameField extends StatelessWidget {
  const HolderNameField({super.key, required this.scrollPadding});

  final EdgeInsets scrollPadding;

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      maxLength: 26,
      formControlName: PaymentCardForm.holderNameKey,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        labelText: 'Nome como aparece no cartão',
        counter: Offstage(),
      ),
      inputFormatters: [UpperCaseTextFormatter()],
      scrollPadding: scrollPadding,
      validationMessages: {
        ValidationMessage.required: (_) => 'O nome é obrigatório',
        ValidationMessage.minLength: (_) => 'O nome inserido é muito curto',
        ValidationMessage.maxLength: (_) => 'O nome inserido é muito longo',
      },
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
