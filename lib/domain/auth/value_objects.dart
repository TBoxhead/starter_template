import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'value_objects.freezed.dart';

class EmailAdress {
  final Either<ValueFailure<String>, String> value;

  factory EmailAdress(String input) {
    assert(input != null);
    return EmailAdress(input);
  }

  EmailAdress.withValue(this.value);
}

@freezed
class ValueFailure<T> with _$ValueFailure<T> {
  const factory ValueFailure.invalidEmail({
    required String failedValue,
  }) = InvalidEmail<T>;
}
