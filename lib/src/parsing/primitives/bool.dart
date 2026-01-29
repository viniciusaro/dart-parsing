part of '../parsing.dart';

class BoolParser with Parser<bool, IterableCollection<int>> {
  @override
  Parser<bool, IterableCollection<int>> body() {
    return OneOf([
      StringLiteral("true").map(bool.parse),
      StringLiteral("false").map(bool.parse),
    ]);
  }
}
