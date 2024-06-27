part of 'parsing.dart';

class BoolParser with Parser<String, bool> {
  @override
  Parser<String, bool> body() {
    return OneOf([
      StringPrefix((s) => s != "true").map(bool.parse),
      StringPrefix((s) => s != "false").map(bool.parse),
    ]);
  }
}
