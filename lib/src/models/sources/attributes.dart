import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:paymongo_sdk/paymongo_sdk.dart';

/// source response
class SourceAttributes extends Equatable {
  ///
  const SourceAttributes(
      {required this.type,
      required this.amount,
      required this.redirect,
      required this.billing,
      this.currency = 'PHP',
      this.metadata,});

  ///
  factory SourceAttributes.fromMap(Map<String, dynamic> map) {
    return SourceAttributes(
      type: map['type']?.toString() ?? '',
      amount: (map['amount'] as num).toDouble(),
      currency: map['currency']?.toString() ?? '',
      redirect: Redirect.fromMap(map['redirect'] as Map<String, dynamic>),
      billing: map['billing'] != null
          ? PayMongoBilling.fromMap(map['billing'] as Map<String, dynamic>)
          : null,
      metadata: map['metdata'] as Map<String, dynamic>?,
    );
  }

  ///
  factory SourceAttributes.fromJson(String source) =>
      SourceAttributes.fromMap(json.decode(source) as Map<String, dynamic>);

  ///
  final String type;

  ///
  final double amount;

  ///
  final String currency;

  ///
  final Redirect redirect;

  ///
  final PayMongoBilling? billing;

  final Map<String, dynamic>? metadata;

  ///
  SourceAttributes copyWith({
    String? type,
    double? amount,
    String? currency,
    Redirect? redirect,
    PayMongoBilling? billing,
  }) {
    return SourceAttributes(
      type: type ?? this.type,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      redirect: redirect ?? this.redirect,
      billing: billing ?? this.billing,
    );
  }

  ///
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'amount': amount.toCurrency(),
      'currency': currency,
      'redirect': redirect.toMap(),
      'billing': billing?.toMap(),
      'metadata': metadata,
    };
  }

  ///
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props {
    return [
      type,
      amount,
      currency,
      redirect,
      billing,
      metadata,
    ];
  }
}
