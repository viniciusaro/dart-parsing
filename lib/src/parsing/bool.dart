part of 'parsing.dart';

class BoolParser with Parser<IterableCollection<int>, bool> {
  @override
  Parser<IterableCollection<int>, bool> body() {
    return OneOf([
      StringLiteral("true").map(bool.parse),
      StringLiteral("false").map(bool.parse),
    ]);
  }
}
