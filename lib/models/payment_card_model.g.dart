// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentCardImpl _$$PaymentCardImplFromJson(Map<String, dynamic> json) =>
    _$PaymentCardImpl(
      cardNumber: _removeWhiteSpaces(json['card_number'] as String),
      holderName: json['holder_name'] as String,
      expDate: DatetimeConverter.fromShortString(json['exp_date'] as String),
      cvv: json['cvv'] as String?,
    );

Map<String, dynamic> _$$PaymentCardImplToJson(_$PaymentCardImpl instance) =>
    <String, dynamic>{
      'card_number': instance.cardNumber,
      'holder_name': instance.holderName,
      'exp_date': instance.expDate.toIso8601String(),
      'cvv': instance.cvv,
    };
