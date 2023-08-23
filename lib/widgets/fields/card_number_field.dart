import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:payment_card_form/payment_card_form.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CardNumberField extends StatelessWidget {
  const CardNumberField({
    super.key,
    required this.mask,
    required this.scrollPadding,
  });

  final MaskTextInputFormatter mask;
  final EdgeInsets scrollPadding;

  @override
  Widget build(BuildContext context) {
    return ReactiveValueListenableBuilder<String?>(
      formControlName: PaymentCardForm.cardNumberKey,
      builder: (context, control, _) {
        return ReactiveTextField(
          formControlName: PaymentCardForm.cardNumberKey,
          inputFormatters: [mask],
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: 'Número do cartão',
            suffixIcon: _CreditCardIcon(control.value),
          ),
          scrollPadding: scrollPadding,
          validationMessages: {
            ValidationMessage.creditCard: (_) {
              return 'O número do cartão é inválido';
            },
          },
        );
      },
    );
  }
}

class _CreditCardIcon extends StatelessWidget {
  const _CreditCardIcon(this.number);

  final String? number;

  CreditCardType get cardType {
    return number == null ? CreditCardType.unknown : detectCCType(number!);
  }

  @override
  Widget build(BuildContext context) {
    switch (cardType) {
      case CreditCardType.amex:
      case CreditCardType.dinersclub:
      case CreditCardType.discover:
      case CreditCardType.elo:
      case CreditCardType.jcb:
      case CreditCardType.maestro:
      case CreditCardType.mastercard:
      case CreditCardType.hipercard:
      case CreditCardType.hiper:
      case CreditCardType.visa:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Image.asset(
            'packages/payment_card_form/assets/images/card_icons/${cardType.name}.png',
            height: 15,
            width: 22,
          ),
        );
      case CreditCardType.unknown:
      default:
        return const Icon(Icons.credit_card);
    }
  }
}
