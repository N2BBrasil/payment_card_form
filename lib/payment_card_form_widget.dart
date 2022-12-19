import 'dart:async';

import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:payment_card_form/models/models.dart';
import 'package:payment_card_form/shared/shared.dart';
import 'package:reactive_forms/reactive_forms.dart';

typedef OnPaymentCardFormChange = Function(
  Map<String, Object?>? formValue,
  bool isPristine,
)?;

class PaymentCardForm extends StatefulWidget {
  const PaymentCardForm({
    Key? key,
    this.autoFocus = false,
    this.onChange,
    this.initialValue,
    this.scrollPadding = const EdgeInsets.all(50),
  }) : super(key: key);

  static const cardNumberKey = 'card_number';
  static const holderNameKey = 'holder_name';
  static const documentNumberKey = 'document_number';
  static const expDateKey = 'exp_date';
  static const cvvKey = 'cvv';

  final OnPaymentCardFormChange? onChange;
  final bool autoFocus;
  final PaymentCard? initialValue;
  final EdgeInsets scrollPadding;

  @override
  PaymentCardFormState createState() => PaymentCardFormState();
}

class PaymentCardFormState extends State<PaymentCardForm> {
  StreamSubscription? valueChangesSubscription;
  final _cardNumberMask = MaskTextInputFormatter(
    mask: '#### #### #### #### ###',
  );
  final _documentMaskFormatter = MaskTextInputFormatter(mask: '###.###.###-##');
  late final FormGroup form;

  PaymentCard? validate() {
    FocusScope.of(context).unfocus();

    if (form.valid) {
      return PaymentCard.fromJson(form.value);
    }

    form.markAllAsTouched();
    form.focus(form.errors.keys.first);
    return null;
  }

  bool isValid() => form.valid;

  bool get isPristineForm =>
      form.controls.values.every((control) => !control.pristine);

  @override
  void initState() {
    form = FormGroup(
      {
        PaymentCardForm.cardNumberKey: FormControl<String>(
          value: widget.initialValue?.cardNumber != null
              ? _cardNumberMask.maskText(widget.initialValue!.cardNumber)
              : null,
          validators: [
            Validators.creditCard,
          ],
        ),
        PaymentCardForm.holderNameKey: FormControl<String>(
          value: widget.initialValue?.holderName,
          validators: [
            Validators.required,
            Validators.minLength(2),
            Validators.maxLength(26),
          ],
        ),
        PaymentCardForm.documentNumberKey: FormControl<String>(
          value: widget.initialValue?.documentNumber != null
              ? _documentMaskFormatter
                  .maskText(widget.initialValue!.documentNumber)
              : null,
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
          value: widget.initialValue?.expDate != null
              ? DateFormat('MM/yy').format(widget.initialValue!.expDate)
              : null,
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
                  (expDate.isBefore(DateTime.now()) &&
                      !expDate.isSameYM(now))) {
                return {'invalid': true};
              }

              return null;
            },
          ],
        ),
        PaymentCardForm.cvvKey: FormControl<String>(
          value: widget.initialValue?.cvv,
          validators: [
            Validators.minLength(3),
            Validators.required,
          ],
        ),
      },
    );

    if (widget.initialValue != null) {
      form.controls.values.forEach((element) {
        element.markAsPristine();
      });
    }

    super.initState();
    if (widget.onChange != null) {
      valueChangesSubscription = form.valueChanges.listen(
        (value) => widget.onChange!.call(
          value,
          isPristineForm,
        ),
      );
    }

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
    valueChangesSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: form,
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyText2!,
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
                    suffixIcon: _buildCardIcon(control.value),
                  ),
                  scrollPadding: widget.scrollPadding,
                  validationMessages: {
                    ValidationMessage.creditCard: (_) =>
                        'O número do cartão é inválido',
                  },
                );
              },
            ),
            ReactiveTextField(
              maxLength: 26,
              formControlName: PaymentCardForm.holderNameKey,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Nome como aparece no cartão',
                counter: const Offstage(),
              ),
              scrollPadding: widget.scrollPadding,
              validationMessages: {
                ValidationMessage.required: (_) => 'O nome é obrigatório',
                ValidationMessage.minLength: (_) =>
                    'O nome inserido é muito curto',
                ValidationMessage.maxLength: (_) =>
                    'O nome inserido é muito longo',
              },
            ),
            ReactiveTextField(
              formControlName: PaymentCardForm.documentNumberKey,
              inputFormatters: [_documentMaskFormatter],
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'CPF do titular',
              ),
              scrollPadding: widget.scrollPadding,
              validationMessages: {
                ValidationMessage.required: (_) => 'O CPF é obrigatório',
                'cpf': (_) => 'O CPF digitado é inválido',
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
                    scrollPadding: widget.scrollPadding,
                    decoration: const InputDecoration(
                      labelText: 'Validade',
                    ),
                    validationMessages: {
                      ValidationMessage.required: (_) => 'Obrigatório',
                      ValidationMessage.minLength: (_) =>
                          'Preencha a data correntamente',
                      'invalid': (_) => 'Inválida',
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: ReactiveTextField(
                    formControlName: PaymentCardForm.cvvKey,
                    maxLength: 4,
                    scrollPadding: widget.scrollPadding,
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
                              padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Código de segurança (CVV, CVC ou CVE)',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5!
                                                  .copyWith(
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                            const SizedBox(height: 16),
                                            Text(
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
                                      child: Text('OK, ENTENDI!'),
                                      onPressed: () => Navigator.pop(context),
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                      ))
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
                  ),
                ),
              ],
            ),
          ],
        ),
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
