// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PaymentCard _$$_PaymentCardFromJson(Map<String, dynamic> json) =>
    _$_PaymentCard(
      cardNumber: _removeWhiteSpaces(json['card_number'] as String),
      holderName: json['holder_name'] as String,
      documentNumber: _cleanMask(json['document_number'] as String),
      expDate: DatetimeConverter.fromShortString(json['exp_date'] as String),
      cvv: json['cvv'] as String?,
    );

Map<String, dynamic> _$$_PaymentCardToJson(_$_PaymentCard instance) =>
    <String, dynamic>{
      'card_number': instance.cardNumber,
      'holder_name': instance.holderName,
      'document_number': instance.documentNumber,
      'exp_date': instance.expDate.toIso8601String(),
      'cvv': instance.cvv,
    };
