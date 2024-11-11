import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:payment_card_form/payment_card_form.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CVVField extends StatelessWidget {
  const CVVField({
    super.key,
    required this.scrollPadding,
  });

  final EdgeInsets scrollPadding;

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      formControlName: PaymentCardForm.cvvKey,
      maxLength: 4,
      scrollPadding: EdgeInsets.only(bottom: scrollPadding.bottom),
      inputFormatters: [
        MaskTextInputFormatter(
          mask: '####',
        )
      ],
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'CVV',
        counterText: '',
        suffixIcon: IconButton(
          icon: const Icon(Icons.help),
          onPressed: () => showModalBottomSheet(
            context: context,
            isDismissible: true,
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Código de segurança (CVV, CVC ou CVE)',
                                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'O código de segurança é um número de 3 ou 4 dígitos. Na maioria dos cartões, ele é impresso no verso.',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 56),
                        Image.asset(
                          'packages/payment_card_form/assets/images/nutritionist.png',
                          height: 90,
                          fit: BoxFit.cover,
                        )
                      ],
                    ),
                    const SizedBox(width: 36),
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: const Text('OK, ENTENDI!'))
                  ],
                ),
              );
            },
          ),
        ),
      ),
      validationMessages: {
        ValidationMessage.required: (_) => 'Obrigatório',
        ValidationMessage.minLength: (_) => 'Inválido',
      },
    );
  }
}
