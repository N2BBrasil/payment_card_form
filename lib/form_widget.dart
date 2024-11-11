import 'dart:async';

import 'package:card_scanner/card_scanner.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:payment_card_form/models/models.dart';
import 'package:payment_card_form/validators/validators.dart';
import 'package:payment_card_form/widgets/widgets.dart';
import 'package:reactive_forms/reactive_forms.dart';

typedef OnPaymentCardFormChange = Function(Map<String, Object?>? formValue)?;

class PaymentCardForm extends StatefulWidget {
  const PaymentCardForm({
    Key? key,
    this.autoFocus = false,
    this.onChange,
    this.initialValue,
    this.scrollPadding = const EdgeInsets.all(50),
    this.isTesting = false,
    this.allowCVVInsert = false,
    this.shouldShowCardFlag = true,
    this.focusScopeNode,
  }) : super(key: key);

  static const cardNumberKey = 'card_number';
  static const holderNameKey = 'holder_name';
  static const expDateKey = 'exp_date';
  static const cvvKey = 'cvv';

  final OnPaymentCardFormChange? onChange;
  final bool autoFocus;
  final PaymentCard? initialValue;
  final EdgeInsets scrollPadding;
  final bool isTesting;
  final bool allowCVVInsert;
  final bool shouldShowCardFlag;
  final FocusScopeNode? focusScopeNode;

  @override
  PaymentCardFormState createState() => PaymentCardFormState();
}

class PaymentCardFormState extends State<PaymentCardForm> {
  StreamSubscription? valueChangesSubscription;
  final _cardNumberMask = MaskTextInputFormatter(
    mask: '#### #### #### #### ###',
  );
  late final FormGroup form;

  PaymentCard? validate() {
    FocusScope.of(context).unfocus();

    if (form.valid) return PaymentCard.fromJson(form.value);

    form.markAllAsTouched();
    form.focus(form.errors.keys.first);
    return null;
  }

  void setCard(CardDetails card) {
    form.control(PaymentCardForm.cardNumberKey).value =
        card.cardNumber.isEmpty ? null : _cardNumberMask.maskText(card.cardNumber);
    form.control(PaymentCardForm.holderNameKey).value =
        card.cardHolderName.isEmpty ? null : card.cardHolderName;
    form.control(PaymentCardForm.expDateKey).value =
        card.expiryDate.isEmpty ? null : card.expiryDate;
  }

  bool isValid() => form.valid;

  bool get isPristineForm {
    return form.controls.values.every((control) => !control.pristine);
  }

  bool get isFilledForm {
    return form.controls.values.every((control) => control.value != null);
  }

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
        PaymentCardForm.expDateKey: FormControl<String>(
          value: widget.initialValue?.expDate != null
              ? DateFormat('MM/yy').format(widget.initialValue!.expDate)
              : null,
          validators: [if (!widget.isTesting) const ExpirationDateValidator()],
        ),
        if (widget.allowCVVInsert)
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
      widget.onChange?.call(form.value);
      for (var element in form.controls.values) {
        element.markAsPristine();
      }
    }

    super.initState();
    if (widget.onChange != null) {
      valueChangesSubscription = form.valueChanges.listen(
        (value) {
          widget.onChange!.call(value);
        },
      );
    }

    if (widget.autoFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Scrollable.ensureVisible(
          context,
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
        style: Theme.of(context).textTheme.bodyMedium!,
        child: FocusScope(
          node: widget.focusScopeNode,
          child: Wrap(
            runSpacing: 16,
            children: [
              CardNumberField(
                mask: _cardNumberMask,
                scrollPadding: widget.scrollPadding,
                shouldShowCardFlag: widget.shouldShowCardFlag,
              ),
              if (widget.allowCVVInsert)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: ExpirationDateField(scrollPadding: widget.scrollPadding),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: CVVField(scrollPadding: widget.scrollPadding),
                    ),
                  ],
                )
              else
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: ExpirationDateField(scrollPadding: widget.scrollPadding),
                ),
              HolderNameField(scrollPadding: widget.scrollPadding),
            ],
          ),
        ),
      ),
    );
  }
}
