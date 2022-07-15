import 'dart:async';

import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:payment_card_form/models/models.dart';
import 'package:payment_card_form/shared/shared.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentCardForm extends StatefulWidget {
  const PaymentCardForm({
    Key? key,
    required this.onChange,
    this.validationMessages,
    this.termsOfUseUri,
    this.privacyPoliciesUri,
    this.autoFocus = false,
  }) : super(key: key);

  static const cardNumberKey = 'card_number';
  static const holderNameKey = 'holder_name';
  static const documentNumberKey = 'document_number';
  static const expDateKey = 'exp_date';
  static const cvvKey = 'cvv';
  static const termsKey = 'terms';

  final Map<ValidationMessage, String>? validationMessages;
  final Function(Map<String, Object?>?) onChange;
  final Uri? termsOfUseUri;
  final Uri? privacyPoliciesUri;
  final bool autoFocus;

  @override
  PaymentCardFormState createState() => PaymentCardFormState();
}

class PaymentCardFormState extends State<PaymentCardForm> {
  late StreamSubscription valueChangesSubscription;
  final _cardNumberMask = MaskTextInputFormatter(
    mask: '#### #### #### #### ###',
  );
  final _documentMaskFormatter = MaskTextInputFormatter(mask: '###.###.###-##');
  final form = FormGroup(
    {
      PaymentCardForm.cardNumberKey: FormControl<String>(
        validators: [Validators.creditCard],
      ),
      PaymentCardForm.holderNameKey: FormControl<String>(
        validators: [Validators.required],
      ),
      PaymentCardForm.documentNumberKey: FormControl<String>(
        validators: [
          (control) {
            if (control.isNull) {
              return {'required': true};
            }

            return (CpfUtils.isValid(control.value as String?))
                ? null
                : {'cpf': true};
          },
        ],
      ),
      PaymentCardForm.expDateKey: FormControl<String>(
        validators: [
          (control) {
            final value = control.value as String?;

            if (control.isNull || (value != null && value.isEmpty)) {
              return {'required': true};
            }

            if (value!.length < 5) return {'minLength': true};

            final now = DateTime.now();
            final month = int.parse(value.split('/').first);
            final expDate = DatetimeConverter.fromShortString(
              control.value as String,
            );
            if (month <= 0 ||
                month > 12 ||
                (expDate.isBefore(DateTime.now()) && !expDate.isSameYM(now))) {
              return {'invalid': true};
            }

            return null;
          },
        ],
      ),
      PaymentCardForm.cvvKey: FormControl<String>(
        validators: [Validators.minLength(3), Validators.required],
      ),
      PaymentCardForm.termsKey: FormControl<bool>(
        value: false,
        validators: [Validators.requiredTrue],
      ),
    },
  );

  PaymentCard? validate() {
    if (!form.valid) {
      form.markAllAsTouched();
      form.focus(form.errors.keys.first);

      if (form.errors.length == 1 &&
          form.errors.containsKey(PaymentCardForm.termsKey)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Para prosseguir, você precisa aceitar nossos termos de uso e políticas de privacidade.',
            ),
          ),
        );
      }

      return null;
    }

    final parsedValue = form.value.map(
      (key, value) {
        if (key == PaymentCardForm.cardNumberKey) {
          value = _cardNumberMask.getUnmaskedText();
        } else if (key == PaymentCardForm.documentNumberKey) {
          value = _documentMaskFormatter.getUnmaskedText();
        } else if (key == PaymentCardForm.cvvKey) {
          value = int.parse(value! as String);
        }

        return MapEntry(key, value);
      },
    );

    return PaymentCard.fromJson(parsedValue);
  }

  bool allFormPristine() {
    return form.controls.values
        .where((control) => control != form.control(PaymentCardForm.termsKey))
        .every((control) => !control.pristine);
  }

  @override
  void initState() {
    super.initState();
    valueChangesSubscription =
        form.valueChanges.listen((value) => widget.onChange(value));

    if (widget.autoFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Scrollable.ensureVisible(
          this.context,
          curve: Curves.fastOutSlowIn,
          duration: const Duration(milliseconds: 500),
          alignment: 0.5,
        );
      });
    }
  }

  @override
  void dispose() {
    valueChangesSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: form,
      child: Wrap(
        runSpacing: 24,
        children: [
          ReactiveValueListenableBuilder<String?>(
            formControlName: PaymentCardForm.cardNumberKey,
            builder: (context, control, _) {
              return ReactiveTextField(
                formControlName: PaymentCardForm.cardNumberKey,
                inputFormatters: [_cardNumberMask],
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Número do cartão',
                  prefixIcon: _buildCardIcon(control.value),
                ),
                validationMessages: (control) => {
                  ValidationMessage.creditCard: 'O número do cartão é inválido',
                },
              );
            },
          ),
          ReactiveTextField(
            formControlName: PaymentCardForm.holderNameKey,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'Nome completo',
            ),
            validationMessages: (control) => {
              ValidationMessage.required: 'O nome é obrigatório',
            },
          ),
          ReactiveTextField(
            formControlName: PaymentCardForm.documentNumberKey,
            inputFormatters: [_documentMaskFormatter],
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'CPF',
            ),
            validationMessages: (control) => {
              ValidationMessage.required: 'O CPF é obrigatório',
              'cpf': 'O CPF digitado é inválido',
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: ReactiveTextField(
                  formControlName: PaymentCardForm.expDateKey,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                    MaskTextInputFormatter(
                      mask: '##/##',
                    ),
                  ],
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Validade',
                  ),
                  validationMessages: (control) => {
                    ValidationMessage.required: 'A validade é obrigatória',
                    ValidationMessage.minLength:
                        'Preencha a data correntamente',
                    'invalid': 'A validade é inválida',
                  },
                ),
              ),
              const SizedBox(width: 16),
              Flexible(
                child: ReactiveTextField(
                  formControlName: PaymentCardForm.cvvKey,
                  maxLength: 4,
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
                      icon: const Icon(Icons.info),
                      onPressed: () => showModalBottomSheet(
                        context: context,
                        isDismissible: true,
                        builder: (context) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 24,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Código de segurança (CVV, CVC ou CVE)',
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'O código de segurança é um número de 3 ou 4 dígitos. Na maioria dos cartões, ele é impresso no verso.',
                                ),
                                const SizedBox(height: 36),
                                TextButton(
                                  child: Text('OK, ENTENDI!'),
                                  onPressed: () => Navigator.pop(context),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  validationMessages: (control) => {
                    ValidationMessage.required: 'O CVV é obrigatório',
                    ValidationMessage.minLength: 'O CVV é inválido',
                  },
                ),
              ),
            ],
          ),
          ReactiveCheckboxListTile(
            formControlName: PaymentCardForm.termsKey,
            controlAffinity: ListTileControlAffinity.leading,
            title: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.caption,
                children: [
                  const TextSpan(text: 'Li e concordo com os '),
                  if (widget.termsOfUseUri != null)
                    TextSpan(
                      text: 'Termos de uso',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => launchUrl(widget.termsOfUseUri!),
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            color: const Color(0xFF01579B),
                          ),
                    ),
                  if (widget.privacyPoliciesUri != null &&
                      widget.termsOfUseUri != null)
                    const TextSpan(text: ' e '),
                  if (widget.privacyPoliciesUri != null)
                    TextSpan(
                      text: 'Políticas de Privacidade',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => launchUrl(widget.privacyPoliciesUri!),
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            color: const Color(0xFF01579B),
                          ),
                    ),
                  const TextSpan(text: '.'),
                ],
              ),
            ),
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  Widget _buildCardIcon(String? value) {
    final type = value == null ? CreditCardType.unknown : detectCCType(value);

    switch (type) {
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
            'packages/payment_card_form/assets/images/card_icons/${type.name}.png',
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
