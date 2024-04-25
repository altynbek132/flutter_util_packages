import 'package:freezed_annotation/freezed_annotation.dart';

part 'custom_exception.freezed.dart';
part 'custom_exception.g.dart';

@freezed
class CustomExceptionFreezed with _$CustomExceptionFreezed {
  @Implements<Exception>()
  factory CustomExceptionFreezed({
    required String message,
  }) = CustomException;

  factory CustomExceptionFreezed.fromJson(Map<String, dynamic> json) => _$CustomExceptionFreezedFromJson(json);
}
