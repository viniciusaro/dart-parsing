part of '../parsing.dart';

class BoolParser with Parser<bool, CodeUnits> {
  @override
  Parser<bool, CodeUnits> body() {
    return OneOf([
      StringLiteral("true").map((_) => true),
      StringLiteral("false").map((_) => false),
    ]);
  }
}
