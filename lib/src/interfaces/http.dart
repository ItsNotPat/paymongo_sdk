import 'dart:convert';

import 'package:http/http.dart';
import 'package:paymongo_sdk/paymongo_sdk.dart';

/// Serialize json from [String] to Dart [Object]
mixin PaymentResponseSerializer {
  /// Convert Json response to [T] and
  /// throws [ClientException] for client error response.
  ///
  /// [onSerializedCallback] returns the type you want.
  ///
  /// for the Payment listAll method returns different type of
  /// json.
  T serialize<T>(
    Response response,
    String path, {
    T Function(Object json)? onSerializedCallback,
  }) {
    final json = jsonDecode(response.body);
    if (json?['errors'] != null) {
      final jsonErrors =
          List<Map<String, dynamic>>.from(json['errors'] as List).toList();
      final errors = jsonErrors.map(PaymongoErrorCodes.fromMap).toList();
      throw PaymongoError(
        "Error ${response.statusCode}",
        paymongoErrors: errors,
      );
    }
    return onSerializedCallback?.call(json as Object) ?? json?['data'] as T;
  }
}
