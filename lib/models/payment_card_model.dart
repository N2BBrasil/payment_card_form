import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:payment_card_form/shared/shared.dart';

part 'payment_card_model.freezed.dart';

part 'payment_card_model.g.dart';

@freezed
class PaymentCard with _$PaymentCard {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory PaymentCard({
    @JsonKey(fromJson: _removeWhiteSpaces) required String cardNumber,
    required String holderName,
    @JsonKey(fromJson: DatetimeConverter.fromShortString) required DateTime expDate,
    String? cvv,
  }) = _PaymentCard;

  factory PaymentCard.fromJson(Map<String, Object?> json) => _$PaymentCardFromJson(json);
}

String _removeWhiteSpaces(String value) => value.replaceAll(RegExp(r"\s+\b|\b\s"), "");
