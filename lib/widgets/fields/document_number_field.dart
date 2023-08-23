import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:payment_card_form/payment_card_form.dart';
import 'package:reactive_forms/reactive_forms.dart';

class DocumentNumberField extends StatelessWidget {
  const DocumentNumberField({
    super.key,
    required this.mask,
    required this.scrollPadding,
  });

  final MaskTextInputFormatter mask;
  final EdgeInsets scrollPadding;

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      formControlName: PaymentCardForm.documentNumberKey,
      inputFormatters: [mask],
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'CPF do titular',
      ),
      scrollPadding: scrollPadding,
      validationMessages: {
        ValidationMessage.required: (_) => 'O CPF é obrigatório',
        'cpf': (_) => 'O CPF digitado é inválido',
      },
    );
  }
}
