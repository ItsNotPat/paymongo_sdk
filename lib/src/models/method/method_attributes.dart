import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:paymongo_sdk/paymongo_sdk.dart';

/// payment option when using card payment
enum PaymentType {
  /// default payment option for card payment
  card,

  /// new version for card payment
  paymaya,

  /// non-implemented value
  unknown,
}

PaymentType _toPaymentEnum(String type) {
  switch (type) {
    case 'paymaya':
      return PaymentType.paymaya;
    default:
      return PaymentType.card;
  }
}

///{@template payment_method}
/// billing for customer
///{@endtemplate}
class PaymentMethodAttributes extends Equatable {
  /// {@macro payment_method}
  const PaymentMethodAttributes({
    required this.details,
    required this.billing,
    this.type = PaymentType.card,
  });

  /// {@macro payment_method}
  factory PaymentMethodAttributes.fromMap(Map<String, dynamic> map) {
    return PaymentMethodAttributes(
      type: map['type'] != null
          ? _toPaymentEnum(map['type']!.toString())
          : PaymentType.card,
      details:
          PaymentMethodDetails.fromMap(map['details'] as Map<String, dynamic>),
      billing: PayMongoBilling.fromMap(map['billing'] as Map<String, dynamic>),
    );
  }

  /// {@macro payment_method}
  factory PaymentMethodAttributes.fromJson(String source) =>
      PaymentMethodAttributes.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  ///
  final PaymentType type;

  ///
  final PaymentMethodDetails details;

  ///
  final PayMongoBilling billing;
  @override
  List<Object> get props => [type, details, billing];

  /// {@macro payment_method}
  Map<String, dynamic> toMap() {
    return {
      'type': type.describeEnum(),
      'details': details.toMap(),
      'billing': billing.toMap(),
    };
  }

  /// {@macro payment_method}
  String toJson() => json.encode(toMap());

  /// {@macro payment_method}
  PaymentMethodAttributes copyWith({
    PaymentType? type,
    PaymentMethodDetails? details,
    PayMongoBilling? billing,
  }) {
    return PaymentMethodAttributes(
      type: type ?? this.type,
      details: details ?? this.details,
      billing: billing ?? this.billing,
    );
  }

  @override
  bool get stringify => true;
}

/// {@template payment_method_details}
/// {@endtemplate}
class PaymentMethodDetails extends Equatable {
  /// {@macro payment_method_details}
  const PaymentMethodDetails({
    required this.cardNumber,
    required this.expMonth,
    required this.expYear,
    required this.cvc,
  });

  /// {@macro payment_method_details}
  factory PaymentMethodDetails.fromMap(Map<String, dynamic> map) {
    return PaymentMethodDetails(
      cardNumber: map['card_number']?.toString() ?? '',
      expMonth: map['exp_month'] as int? ?? 0,
      expYear: map['exp_ear'] as int? ?? 0,
      cvc: map['cvc']?.toString() ?? '',
    );
  }

  /// {@macro payment_method_details}
  factory PaymentMethodDetails.fromJson(String source) =>
      PaymentMethodDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  ///
  final String cardNumber;

  ///
  final int expMonth;

  ///
  final int expYear;

  ///
  final String cvc;

  @override
  List<Object> get props => [cardNumber, expMonth, expYear, cvc];

  /// {@macro payment_method_details}
  PaymentMethodDetails copyWith({
    String? cardNumber,
    int? expMonth,
    int? expYear,
    String? cvc,
  }) {
    return PaymentMethodDetails(
      cardNumber: cardNumber ?? this.cardNumber,
      expMonth: expMonth ?? this.expMonth,
      expYear: expYear ?? this.expYear,
      cvc: cvc ?? this.cvc,
    );
  }

  /// {@macro payment_method_details}
  Map<String, dynamic> toMap() {
    return {
      'card_number': cardNumber,
      'exp_month': expMonth,
      'exp_year': expYear,
      'cvc': cvc,
    };
  }

  /// {@macro payment_method_details}
  String toJson() => json.encode(toMap());
}
