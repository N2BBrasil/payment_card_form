import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:flutter/material.dart';

class CardBrandIcon extends StatelessWidget {
  const CardBrandIcon(
    this.number, {
    this.unknownIcon,
    this.iconSize = 48,
    super.key,
  });

  final double iconSize;
  final String? number;
  final Widget? unknownIcon;

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
            'assets/images/card_icons/${cardType.name}.png',
            package: 'payment_card_form',
            width: iconSize,
            height: iconSize,
          ),
        );
      case CreditCardType.unknown:
      default:
        return unknownIcon ?? SizedBox(height: iconSize, width: iconSize);
    }
  }
}
