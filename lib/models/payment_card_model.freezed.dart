// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_card_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PaymentCard _$PaymentCardFromJson(Map<String, dynamic> json) {
  return _PaymentCard.fromJson(json);
}

/// @nodoc
mixin _$PaymentCard {
  @JsonKey(fromJson: _removeWhiteSpaces)
  String get cardNumber => throw _privateConstructorUsedError;
  String get holderName => throw _privateConstructorUsedError;
  @JsonKey(fromJson: DatetimeConverter.fromShortString)
  DateTime get expDate => throw _privateConstructorUsedError;
  String? get cvv => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaymentCardCopyWith<PaymentCard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentCardCopyWith<$Res> {
  factory $PaymentCardCopyWith(
          PaymentCard value, $Res Function(PaymentCard) then) =
      _$PaymentCardCopyWithImpl<$Res, PaymentCard>;
  @useResult
  $Res call(
      {@JsonKey(fromJson: _removeWhiteSpaces) String cardNumber,
      String holderName,
      @JsonKey(fromJson: DatetimeConverter.fromShortString) DateTime expDate,
      String? cvv});
}

/// @nodoc
class _$PaymentCardCopyWithImpl<$Res, $Val extends PaymentCard>
    implements $PaymentCardCopyWith<$Res> {
  _$PaymentCardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cardNumber = null,
    Object? holderName = null,
    Object? expDate = null,
    Object? cvv = freezed,
  }) {
    return _then(_value.copyWith(
      cardNumber: null == cardNumber
          ? _value.cardNumber
          : cardNumber // ignore: cast_nullable_to_non_nullable
              as String,
      holderName: null == holderName
          ? _value.holderName
          : holderName // ignore: cast_nullable_to_non_nullable
              as String,
      expDate: null == expDate
          ? _value.expDate
          : expDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      cvv: freezed == cvv
          ? _value.cvv
          : cvv // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaymentCardImplCopyWith<$Res>
    implements $PaymentCardCopyWith<$Res> {
  factory _$$PaymentCardImplCopyWith(
          _$PaymentCardImpl value, $Res Function(_$PaymentCardImpl) then) =
      __$$PaymentCardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(fromJson: _removeWhiteSpaces) String cardNumber,
      String holderName,
      @JsonKey(fromJson: DatetimeConverter.fromShortString) DateTime expDate,
      String? cvv});
}

/// @nodoc
class __$$PaymentCardImplCopyWithImpl<$Res>
    extends _$PaymentCardCopyWithImpl<$Res, _$PaymentCardImpl>
    implements _$$PaymentCardImplCopyWith<$Res> {
  __$$PaymentCardImplCopyWithImpl(
      _$PaymentCardImpl _value, $Res Function(_$PaymentCardImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cardNumber = null,
    Object? holderName = null,
    Object? expDate = null,
    Object? cvv = freezed,
  }) {
    return _then(_$PaymentCardImpl(
      cardNumber: null == cardNumber
          ? _value.cardNumber
          : cardNumber // ignore: cast_nullable_to_non_nullable
              as String,
      holderName: null == holderName
          ? _value.holderName
          : holderName // ignore: cast_nullable_to_non_nullable
              as String,
      expDate: null == expDate
          ? _value.expDate
          : expDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      cvv: freezed == cvv
          ? _value.cvv
          : cvv // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$PaymentCardImpl implements _PaymentCard {
  const _$PaymentCardImpl(
      {@JsonKey(fromJson: _removeWhiteSpaces) required this.cardNumber,
      required this.holderName,
      @JsonKey(fromJson: DatetimeConverter.fromShortString)
      required this.expDate,
      this.cvv});

  factory _$PaymentCardImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentCardImplFromJson(json);

  @override
  @JsonKey(fromJson: _removeWhiteSpaces)
  final String cardNumber;
  @override
  final String holderName;
  @override
  @JsonKey(fromJson: DatetimeConverter.fromShortString)
  final DateTime expDate;
  @override
  final String? cvv;

  @override
  String toString() {
    return 'PaymentCard(cardNumber: $cardNumber, holderName: $holderName, expDate: $expDate, cvv: $cvv)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentCardImpl &&
            (identical(other.cardNumber, cardNumber) ||
                other.cardNumber == cardNumber) &&
            (identical(other.holderName, holderName) ||
                other.holderName == holderName) &&
            (identical(other.expDate, expDate) || other.expDate == expDate) &&
            (identical(other.cvv, cvv) || other.cvv == cvv));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, cardNumber, holderName, expDate, cvv);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentCardImplCopyWith<_$PaymentCardImpl> get copyWith =>
      __$$PaymentCardImplCopyWithImpl<_$PaymentCardImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentCardImplToJson(
      this,
    );
  }
}

abstract class _PaymentCard implements PaymentCard {
  const factory _PaymentCard(
      {@JsonKey(fromJson: _removeWhiteSpaces) required final String cardNumber,
      required final String holderName,
      @JsonKey(fromJson: DatetimeConverter.fromShortString)
      required final DateTime expDate,
      final String? cvv}) = _$PaymentCardImpl;

  factory _PaymentCard.fromJson(Map<String, dynamic> json) =
      _$PaymentCardImpl.fromJson;

  @override
  @JsonKey(fromJson: _removeWhiteSpaces)
  String get cardNumber;
  @override
  String get holderName;
  @override
  @JsonKey(fromJson: DatetimeConverter.fromShortString)
  DateTime get expDate;
  @override
  String? get cvv;
  @override
  @JsonKey(ignore: true)
  _$$PaymentCardImplCopyWith<_$PaymentCardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
