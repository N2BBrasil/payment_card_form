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

  static const double _kCreditCardAspectRatio = 0.5714;
  static const String _kSixteenX = '0000 0000 0000 0000';

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final Orientation orientation = mediaQueryData.orientation;
    final Size screenSize = mediaQueryData.size;
    final textStyle = Theme.of(context).textTheme.titleLarge!.merge(
          const TextStyle(
            color: Colors.white,
            fontFamily: 'halter',
            fontSize: 16,
            package: 'payment_card_form',
          ),
        );

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double screenWidth =
            constraints.maxWidth.isInfinite ? screenSize.width : constraints.maxWidth;
        final double implicitHeight = orientation.isPortrait
            ? (screenWidth - (padding * 2)) * _kCreditCardAspectRatio
            : screenSize.height / 2;
        return Container(
          margin: EdgeInsets.all(padding),
          width: screenWidth,
          height: implicitHeight,
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.black,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (allowCardScan)
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 16,
                    ),
                    child: OutlinedButton.icon(
                      icon: const Icon(
                        Icons.document_scanner,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'ESCANEAR',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        final cardDetails = await CardScanner.scanCard(
                          scanOptions: CardScanOptions(
                            scanCardHolderName: true,
                            enableLuhnCheck: true,
                            considerPastDatesInExpiryDateScan: isTesting,
                            enableDebugLogs: isTesting,
                          ),
                        );
                        if (cardDetails != null) onCardScanned!.call(cardDetails);
                      },
                    ),
                  ),
                ),
              const Spacer(),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 16),
                child: Text(
                  cardNumber.isNotNullAndNotEmpty ? cardNumber! : _kSixteenX,
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
                      style: textStyle.copyWith(fontSize: 10),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        holderName.isNotNullAndNotEmpty ? holderName! : 'NOME DO TITULAR',
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
