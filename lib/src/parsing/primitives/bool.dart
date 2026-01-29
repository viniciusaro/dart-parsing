part of '../parsing.dart';

class BoolParser with Parser<bool, MutableStringSlice> {
  @override
  Parser<bool, MutableStringSlice> body() {
    return OneOf([
      StringLiteral("true").map((_) => true),
      StringLiteral("false").map((_) => false),
    ]);
  }
}
