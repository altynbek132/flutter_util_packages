import 'dart:async';
import 'dart:convert';

import 'package:utils/src/utils_dart/index_start_end.dart';

extension StringExtension on String {
  String substring_(int start, [int? end]) {
    if (end != null && end < 0) {
      end = length + end;
    }

    final (start_, end_) = indexStartEnd(length, start, end);
    return substring(start_, end_);
  }

  String substr(int start, [int length = 0]) {
    if (length < 0) {
      length = 0;
    }
    return substring_(start, start + length);
  }
}

extension StringExtensionEff on String? {
  String get eff => this ?? '';
}

String jsonStr(
  Object? object, {
  bool pretty = false,
  // todo: add encoder
}) {
  Object? toEncodable(object) {
    // todo: remove
    if (object is Completer) {
      return 'Completer';
    }
    if (object is BigInt) {
      return object.toString();
    }
    return object;
  }

  if (pretty) {
    return JsonEncoder.withIndent(' ', toEncodable).convert(object);
  }
  return json.encode(object, toEncodable: toEncodable);
}

extension StringDupExtension on String {
  String dup(int count) {
    return List.generate(count, (index) => this).join(' ');
  }
}
