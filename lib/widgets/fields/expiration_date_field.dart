import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:payment_card_form/payment_card_form.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ExpirationDateField extends StatelessWidget {
  const ExpirationDateField({
    super.key,
    required this.scrollPadding,
  });

  final EdgeInsets scrollPadding;

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      formControlName: PaymentCardForm.expDateKey,
      textInputAction: TextInputAction.next,
      inputFormatters: [
        MaskTextInputFormatter(
          mask: '##/##',
        ),
      ],
      keyboardType: TextInputType.number,
      scrollPadding: scrollPadding,
      decoration: const InputDecoration(
        labelText: 'Validade',
      ),
      validationMessages: {
        ValidationMessage.required: (_) => 'Obrigatório',
        ValidationMessage.minLength: (_) => 'Preencha a data correntamente',
        'invalid': (_) => 'Inválida',
      },
    );
  }
}
