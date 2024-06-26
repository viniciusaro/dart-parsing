part of 'parsing.dart';

class BoolParser2 with Parser<StringCollection, bool> {
  @override
  Parser<StringCollection, bool> body() {
    return OneOf([
      StringPrefix2((s) => s != "true").map((s) => s.source).map(bool.parse),
      StringPrefix2((s) => s != "false").map((s) => s.source).map(bool.parse),
    ]);
  }
}
