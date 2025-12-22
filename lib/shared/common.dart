import 'dart:convert';

import 'package:flutter/foundation.dart';

void printValue(dynamic value, {String tag = ""}) {
  if (!kDebugMode) return;

  try {
    // Try to decode if it's a JSON string
    final decodedJSON = json.decode(value.toString());

    // If it's a Map or List, pretty-print it
    if (decodedJSON is Map || decodedJSON is List) {
      final prettyJson = const JsonEncoder.withIndent(
        '  ',
      ).convert(decodedJSON);
      print("JSON OUTPUT: $tag\n$prettyJson\n");
      return;
    }
  } catch (_) {
    // Not a JSON string, fall through
  }

  // Check if it's already a Map or List
  if (value is Map || value is List) {
    final prettyJson = const JsonEncoder.withIndent('  ').convert(value);
    print("JSON OUTPUT: $tag\n$prettyJson\n");
  } else {
    print("PRINT OUTPUT: $tag $value\n");
  }
}
