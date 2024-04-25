import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:worker_method_channel/src/freezed_annotations.dart';

part 'exception_with_type.freezed.dart';
part 'exception_with_type.g.dart';

@freezedMutable
class ExceptionWithType with _$ExceptionWithType {
  factory ExceptionWithType({
    required final String type,
    required final Object exception,
  }) = _ExceptionWithType;

  factory ExceptionWithType.fromJson(Map<String, dynamic> json) => _$ExceptionWithTypeFromJson(json);
}
