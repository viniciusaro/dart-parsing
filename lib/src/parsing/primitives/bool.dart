part of '../parsing.dart';

class BoolParser with Parser<bool, StringSlice> {
  @override
  Parser<bool, StringSlice> body() {
    return OneOf([
      StringLiteral("true").map((_) => true),
      StringLiteral("false").map((_) => false),
    ]);
  }
}
