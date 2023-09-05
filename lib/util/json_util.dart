import 'dart:convert';

extension JsonUtil on String {
  /// Returns a [Map] from a JSON string.
  Map<String, dynamic> asJson() => jsonDecode(this) as Map<String, dynamic>;
}
