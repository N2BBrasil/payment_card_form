import 'package:flutter/material.dart';
import 'package:payment_card_form/widgets/widgets.dart';

class PaymentCardPreview extends StatelessWidget {
  const PaymentCardPreview({
    this.cardNumber,
    this.expiryDate,
    this.holderName,
    this.isTesting = false,
    double? padding,
    this.isDark = false,
    super.key,
  }) : padding = padding ?? 16.0;

  final double padding;
  final bool isTesting;
  final String? cardNumber;
  final String? holderName;
  final String? expiryDate;
  final bool isDark;

  static const double _kCreditCardAspectRatio = 0.628;
  static const String _kSixteenX = '0000 0000 0000 0000';

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final Orientation orientation = mediaQueryData.orientation;
    final Size screenSize = mediaQueryData.size;
    final colorScheme = (isDark ? const ColorScheme.dark() : const ColorScheme.light()).copyWith(
      primary: Theme.of(context).colorScheme.primary,
    );

    return Theme(
      data: ThemeData(colorScheme: colorScheme),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double screenWidth = constraints.maxWidth.isInfinite ? screenSize.width : constraints.maxWidth;
          final double implicitHeight = orientation.isPortrait
              ? (screenWidth - (padding * 2)) * PaymentCardPreview._kCreditCardAspectRatio
              : screenSize.height / 2;
          final textStyle = Theme.of(context).textTheme.titleLarge!.merge(
                const TextStyle(
                  fontFamily: 'halter',
                  fontSize: 15,
                  package: 'payment_card_form',
                ),
              );

          return Container(
            margin: EdgeInsets.all(padding),
            width: screenWidth,
            height: implicitHeight,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: isDark ? Colors.black : const Color(0xFFE0E0E0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Spacer(),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 16),
                  child: Text(
                    cardNumber.isNotNullAndNotEmpty ? cardNumber! : PaymentCardPreview._kSixteenX,
                    style: textStyle,
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        expiryDate.isNotNullAndNotEmpty ? expiryDate! : '00/00',
                        style: textStyle,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'VALIDADE',
                        style: textStyle.copyWith(fontSize: 7),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          holderName.isNotNullAndNotEmpty ? holderName! : 'NOME',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textStyle,
                        ),
                      ),
                      CardBrandIcon(cardNumber),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

extension NullableStringExtension on String? {
  bool get isNullOrEmpty => this?.isEmpty ?? true;

  bool get isNotNullAndNotEmpty => this?.isNotEmpty ?? false;
}

extension OrientationExtension on Orientation {
  bool get isPortrait => this == Orientation.portrait;

  bool get isLandscape => this == Orientation.landscape;
}
