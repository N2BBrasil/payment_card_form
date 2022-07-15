import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:payment_card_form/shared/shared.dart';

part 'payment_card_model.freezed.dart';
part 'payment_card_model.g.dart';

@freezed
class PaymentCard with _$PaymentCard {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory PaymentCard({
    required String cardNumber,
    required String holderName,
    required String documentNumber,
    @JsonKey(fromJson: DatetimeConverter.fromShortString)
        required DateTime expDate,
    required int cvv,
  }) = _PaymentCard;

  factory PaymentCard.fromJson(Map<String, Object?> json) =>
      _$PaymentCardFromJson(json);
}
