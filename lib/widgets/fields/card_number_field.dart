import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:payment_card_form/payment_card_form.dart';
import 'package:payment_card_form/widgets/brand_icon.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CardNumberField extends StatelessWidget {
  const CardNumberField({
    super.key,
    required this.mask,
    required this.scrollPadding,
    required this.shouldShowCardFlag,
  });

  final MaskTextInputFormatter mask;
  final EdgeInsets scrollPadding;
  final bool shouldShowCardFlag;

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
            suffixIcon: shouldShowCardFlag
                ? CardBrandIcon(
                    control.value,
                    iconSize: 24,
                    unknownIcon: const Icon(Icons.credit_card),
                  )
                : null,
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
