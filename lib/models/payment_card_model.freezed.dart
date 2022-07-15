// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'payment_card_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PaymentCard _$PaymentCardFromJson(Map<String, dynamic> json) {
  return _PaymentCard.fromJson(json);
}

/// @nodoc
mixin _$PaymentCard {
  String get cardNumber => throw _privateConstructorUsedError;
  String get holderName => throw _privateConstructorUsedError;
  String get documentNumber => throw _privateConstructorUsedError;
  @JsonKey(fromJson: DatetimeConverter.fromShortString)
  DateTime get expDate => throw _privateConstructorUsedError;
  int get cvv => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaymentCardCopyWith<PaymentCard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentCardCopyWith<$Res> {
  factory $PaymentCardCopyWith(
          PaymentCard value, $Res Function(PaymentCard) then) =
      _$PaymentCardCopyWithImpl<$Res>;
  $Res call(
      {String cardNumber,
      String holderName,
      String documentNumber,
      @JsonKey(fromJson: DatetimeConverter.fromShortString) DateTime expDate,
      int cvv});
}

/// @nodoc
class _$PaymentCardCopyWithImpl<$Res> implements $PaymentCardCopyWith<$Res> {
  _$PaymentCardCopyWithImpl(this._value, this._then);

  final PaymentCard _value;
  // ignore: unused_field
  final $Res Function(PaymentCard) _then;

  @override
  $Res call({
    Object? cardNumber = freezed,
    Object? holderName = freezed,
    Object? documentNumber = freezed,
    Object? expDate = freezed,
    Object? cvv = freezed,
  }) {
    return _then(_value.copyWith(
      cardNumber: cardNumber == freezed
          ? _value.cardNumber
          : cardNumber // ignore: cast_nullable_to_non_nullable
              as String,
      holderName: holderName == freezed
          ? _value.holderName
          : holderName // ignore: cast_nullable_to_non_nullable
              as String,
      documentNumber: documentNumber == freezed
          ? _value.documentNumber
          : documentNumber // ignore: cast_nullable_to_non_nullable
              as String,
      expDate: expDate == freezed
          ? _value.expDate
          : expDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      cvv: cvv == freezed
          ? _value.cvv
          : cvv // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_PaymentCardCopyWith<$Res>
    implements $PaymentCardCopyWith<$Res> {
  factory _$$_PaymentCardCopyWith(
          _$_PaymentCard value, $Res Function(_$_PaymentCard) then) =
      __$$_PaymentCardCopyWithImpl<$Res>;
  @override
  $Res call(
      {String cardNumber,
      String holderName,
      String documentNumber,
      @JsonKey(fromJson: DatetimeConverter.fromShortString) DateTime expDate,
      int cvv});
}

/// @nodoc
class __$$_PaymentCardCopyWithImpl<$Res> extends _$PaymentCardCopyWithImpl<$Res>
    implements _$$_PaymentCardCopyWith<$Res> {
  __$$_PaymentCardCopyWithImpl(
      _$_PaymentCard _value, $Res Function(_$_PaymentCard) _then)
      : super(_value, (v) => _then(v as _$_PaymentCard));

  @override
  _$_PaymentCard get _value => super._value as _$_PaymentCard;

  @override
  $Res call({
    Object? cardNumber = freezed,
    Object? holderName = freezed,
    Object? documentNumber = freezed,
    Object? expDate = freezed,
    Object? cvv = freezed,
  }) {
    return _then(_$_PaymentCard(
      cardNumber: cardNumber == freezed
          ? _value.cardNumber
          : cardNumber // ignore: cast_nullable_to_non_nullable
              as String,
      holderName: holderName == freezed
          ? _value.holderName
          : holderName // ignore: cast_nullable_to_non_nullable
              as String,
      documentNumber: documentNumber == freezed
          ? _value.documentNumber
          : documentNumber // ignore: cast_nullable_to_non_nullable
              as String,
      expDate: expDate == freezed
          ? _value.expDate
          : expDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      cvv: cvv == freezed
          ? _value.cvv
          : cvv // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_PaymentCard implements _PaymentCard {
  const _$_PaymentCard(
      {required this.cardNumber,
      required this.holderName,
      required this.documentNumber,
      @JsonKey(fromJson: DatetimeConverter.fromShortString)
          required this.expDate,
      required this.cvv});

  factory _$_PaymentCard.fromJson(Map<String, dynamic> json) =>
      _$$_PaymentCardFromJson(json);

  @override
  final String cardNumber;
  @override
  final String holderName;
  @override
  final String documentNumber;
  @override
  @JsonKey(fromJson: DatetimeConverter.fromShortString)
  final DateTime expDate;
  @override
  final int cvv;

  @override
  String toString() {
    return 'PaymentCard(cardNumber: $cardNumber, holderName: $holderName, documentNumber: $documentNumber, expDate: $expDate, cvv: $cvv)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PaymentCard &&
            const DeepCollectionEquality()
                .equals(other.cardNumber, cardNumber) &&
            const DeepCollectionEquality()
                .equals(other.holderName, holderName) &&
            const DeepCollectionEquality()
                .equals(other.documentNumber, documentNumber) &&
            const DeepCollectionEquality().equals(other.expDate, expDate) &&
            const DeepCollectionEquality().equals(other.cvv, cvv));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(cardNumber),
      const DeepCollectionEquality().hash(holderName),
      const DeepCollectionEquality().hash(documentNumber),
      const DeepCollectionEquality().hash(expDate),
      const DeepCollectionEquality().hash(cvv));

  @JsonKey(ignore: true)
  @override
  _$$_PaymentCardCopyWith<_$_PaymentCard> get copyWith =>
      __$$_PaymentCardCopyWithImpl<_$_PaymentCard>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PaymentCardToJson(this);
  }
}

abstract class _PaymentCard implements PaymentCard {
  const factory _PaymentCard(
      {required final String cardNumber,
      required final String holderName,
      required final String documentNumber,
      @JsonKey(fromJson: DatetimeConverter.fromShortString)
          required final DateTime expDate,
      required final int cvv}) = _$_PaymentCard;

  factory _PaymentCard.fromJson(Map<String, dynamic> json) =
      _$_PaymentCard.fromJson;

  @override
  String get cardNumber;
  @override
  String get holderName;
  @override
  String get documentNumber;
  @override
  @JsonKey(fromJson: DatetimeConverter.fromShortString)
  DateTime get expDate;
  @override
  int get cvv;
  @override
  @JsonKey(ignore: true)
  _$$_PaymentCardCopyWith<_$_PaymentCard> get copyWith =>
      throw _privateConstructorUsedError;
}
