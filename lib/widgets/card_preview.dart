import 'package:card_scanner/card_scanner.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:payment_card_form/widgets/widgets.dart';

class PaymentCardPreview extends StatelessWidget {
  const PaymentCardPreview({
    this.cardNumber,
    this.expiryDate,
    this.holderName,
    this.isTesting = false,
    this.onCardScanned,
    bool? allowCardScan,
    double? padding,
    this.isDark = false,
    this.extendedScanButton = true,
    super.key,
  })  : padding = padding ?? 16.0,
        allowCardScan = (allowCardScan ?? false) && !kIsWeb,
        assert(
          allowCardScan == false || onCardScanned != null,
          'onCardScanned is required when allowCardScan is true',
        );

  final void Function(CardDetails card)? onCardScanned;
  final double padding;
  final bool allowCardScan;
  final bool isTesting;
  final String? cardNumber;
  final String? holderName;
  final String? expiryDate;
  final bool isDark;
  final bool extendedScanButton;

  static const double _kCreditCardAspectRatio = 0.628;
  static const String _kSixteenX = '0000 0000 0000 0000';

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final Orientation orientation = mediaQueryData.orientation;
    final Size screenSize = mediaQueryData.size;

    return Theme(
      data: ThemeData(
        colorScheme: isDark ? const ColorScheme.dark() : const ColorScheme.light(),
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double screenWidth =
              constraints.maxWidth.isInfinite ? screenSize.width : constraints.maxWidth;
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
                if (allowCardScan)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16, right: 16),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: isDark ? Colors.white : Colors.black,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: _onScanCard,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.credit_card),
                            if (extendedScanButton) ...[
                              const SizedBox(width: 8),
                              const Text('ESCANEAR CARTÃO'),
                            ]
                          ],
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 8),
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

  void _onScanCard() async {
    final cardDetails = await CardScanner.scanCard(
      scanOptions: CardScanOptions(
        scanCardHolderName: true,
        enableLuhnCheck: true,
        considerPastDatesInExpiryDateScan: isTesting,
        enableDebugLogs: isTesting,
      ),
    );
    if (cardDetails != null) onCardScanned!.call(cardDetails);
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
